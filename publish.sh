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
      --exclude '.git' \
      --exclude '.bundle' \
      --exclude '_site' \
      --exclude 'vendor' \
      --exclude 'node_modules' \
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
git push origin "$BRANCH"

echo "Published successfully."
echo "Site: https://xichie.github.io/"
