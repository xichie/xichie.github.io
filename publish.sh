#!/usr/bin/env bash
set -euo pipefail

if [[ "${1:-}" == "--no-build" ]]; then
  SKIP_BUILD=1
  shift
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(git -C "$SCRIPT_DIR" rev-parse --show-toplevel)"
cd "$ROOT"

BRANCH="${BRANCH:-$(git branch --show-current)}"
if [[ -z "$BRANCH" ]]; then
  echo "Cannot publish from a detached HEAD."
  exit 1
fi

MESSAGE="${*:-Update homepage $(date '+%Y-%m-%d %H:%M')}"

if [[ -n "$(git diff --name-only --diff-filter=U)" ]]; then
  echo "Unresolved merge conflicts found. Resolve them before publishing."
  git diff --name-only --diff-filter=U
  exit 1
fi

if [[ -z "$(git status --porcelain=v1)" ]]; then
  echo "No changes to publish."
  exit 0
fi

echo "Checking whitespace..."
git diff --check
git diff --cached --check

if [[ "${SKIP_BUILD:-0}" != "1" ]]; then
  if command -v bundle >/dev/null 2>&1; then
    TMP_BASE="$(mktemp -d "${TMPDIR:-/tmp}/homepage-publish.XXXXXX")"
    cleanup() {
      rm -rf "$TMP_BASE"
    }
    trap cleanup EXIT

    echo "Building site in a temporary copy..."
    rsync -a \
      --exclude '/.git/' \
      --exclude '/.bundle/' \
      --exclude '/_site/' \
      --exclude '/vendor/' \
      --exclude '/node_modules/' \
      "$ROOT/" "$TMP_BASE/site/"

    (
      cd "$TMP_BASE/site"
      export BUNDLE_PATH="${BUNDLE_PATH:-${TMPDIR:-/tmp}/jiaxingqi-homepage-bundle}"
      export BUNDLE_BUILD__NOKOGIRI="${BUNDLE_BUILD__NOKOGIRI:---use-system-libraries}"
      bundle check || bundle install
      bundle exec jekyll build
    )
  else
    echo "bundle was not found; skipping local Jekyll build."
  fi
else
  echo "Skipping local Jekyll build."
fi

echo "Staging changes..."
git add -A

if git diff --cached --quiet; then
  echo "No staged changes to publish."
  exit 0
fi

echo "Creating commit..."
git commit -m "$MESSAGE"

echo "Rebasing on origin/$BRANCH..."
git pull --rebase origin "$BRANCH"

echo "Pushing to origin/$BRANCH..."
PAGES_RUN_AFTER="$(date -u '+%Y-%m-%dT%H:%M:%SZ')"
git push origin "$BRANCH"

echo "Pushed successfully."

if command -v gh >/dev/null 2>&1; then
  REPO="$(git config --get remote.origin.url | sed -E 's#^git@github.com:##; s#^https://github.com/##; s#\.git$##')"
  if [[ "$REPO" == */* ]]; then
    echo "Waiting for GitHub Pages deployment..."

    find_pages_run() {
      local after="$1"
      local excluded_run_id="${2:-}"
      local run_id=""

      for _ in {1..12}; do
        run_id="$(gh api "repos/$REPO/actions/runs?per_page=20&exclude_pull_requests=true" \
          --jq ".workflow_runs | map(select(.name == \"pages build and deployment\" and .created_at >= \"$after\" and (.id|tostring) != \"$excluded_run_id\"))[0].id // \"\"" 2>/dev/null || true)"
        if [[ -n "$run_id" ]]; then
          echo "$run_id"
          return 0
        fi
        sleep 5
      done

      return 1
    }

    sleep 5
    RUN_ID="$(find_pages_run "$PAGES_RUN_AFTER" || true)"

    if [[ -n "$RUN_ID" ]]; then
      if gh run watch "$RUN_ID" --repo "$REPO" --exit-status; then
        echo "GitHub Pages deployed successfully."
      else
        echo "GitHub Pages deployment failed; requesting one rebuild retry..."
        RETRY_AFTER="$(date -u '+%Y-%m-%dT%H:%M:%SZ')"
        gh api -X POST "repos/$REPO/pages/builds" >/dev/null
        RETRY_RUN_ID="$(find_pages_run "$RETRY_AFTER" "$RUN_ID" || true)"
        if [[ -n "$RETRY_RUN_ID" ]]; then
          gh run watch "$RETRY_RUN_ID" --repo "$REPO" --exit-status
          echo "GitHub Pages deployed successfully after retry."
        else
          echo "Could not find the retry GitHub Pages deployment run. Check Actions manually."
          exit 1
        fi
      fi
    else
      echo "Could not find the GitHub Pages deployment run. Check Actions manually."
    fi
  else
    echo "Could not infer GitHub repo from origin URL. Check Pages deployment manually."
  fi
else
  echo "gh was not found; check GitHub Pages deployment manually."
fi

echo "Site: https://xichie.github.io/"
