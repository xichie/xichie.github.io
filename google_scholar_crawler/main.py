import json
import os
import re
import sys
import time
from datetime import datetime, timezone
from urllib.parse import parse_qs, urlparse

import requests
from bs4 import BeautifulSoup


SCHOLAR_URL = "https://scholar.google.com/citations"
USER_AGENT = (
    "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 "
    "(KHTML, like Gecko) Chrome/124.0 Safari/537.36"
)


def parse_int(text):
    digits = re.sub(r"[^\d]", "", text or "")
    return int(digits) if digits else 0


def fetch_profile(scholar_id):
    params = {
        "user": scholar_id,
        "hl": "en",
        "pagesize": "100",
    }
    headers = {
        "User-Agent": USER_AGENT,
        "Accept-Language": "en-US,en;q=0.9",
    }

    last_error = None
    for attempt in range(1, 4):
        try:
            response = requests.get(
                SCHOLAR_URL,
                params=params,
                headers=headers,
                timeout=(10, 30),
            )
            response.raise_for_status()
            if "detected unusual traffic" in response.text.lower():
                raise RuntimeError("Google Scholar returned an unusual-traffic page")
            return response.text
        except Exception as exc:
            last_error = exc
            print(f"Fetch attempt {attempt}/3 failed: {exc}", file=sys.stderr)
            if attempt < 3:
                time.sleep(5 * attempt)

    raise RuntimeError(f"Could not fetch Google Scholar profile: {last_error}")


def parse_stats(soup):
    stats = {}
    key_map = {
        "citations": ("citedby", "citedby5y"),
        "h-index": ("hindex", "hindex5y"),
        "i10-index": ("i10index", "i10index5y"),
    }

    for row in soup.select("#gsc_rsb_st tbody tr"):
        cells = row.find_all("td")
        if len(cells) < 2:
            continue
        label = cells[0].get_text(" ", strip=True).lower()
        if label not in key_map:
            continue
        all_key, recent_key = key_map[label]
        stats[all_key] = parse_int(cells[1].get_text(" ", strip=True))
        if len(cells) > 2:
            stats[recent_key] = parse_int(cells[2].get_text(" ", strip=True))

    if "citedby" not in stats:
        meta = soup.find("meta", attrs={"name": "description"})
        content = meta.get("content", "") if meta else ""
        match = re.search(r"Cited by\s+([\d,]+)", content)
        if match:
            stats["citedby"] = parse_int(match.group(1))

    return stats


def parse_cites_per_year(soup):
    years = [node.get_text(strip=True) for node in soup.select(".gsc_g_t")]
    counts = [parse_int(node.get_text(strip=True)) for node in soup.select(".gsc_g_al")]
    return {
        year: count
        for year, count in zip(years, counts)
        if year and count is not None
    }


def parse_publications(soup):
    publications = {}

    for row in soup.select("tr.gsc_a_tr"):
        title_node = row.select_one(".gsc_a_at")
        if not title_node:
            continue

        href = title_node.get("href", "")
        query = parse_qs(urlparse(href).query)
        paper_id = query.get("citation_for_view", [""])[0]
        if not paper_id:
            continue

        gray_fields = row.select(".gs_gray")
        authors = gray_fields[0].get_text(" ", strip=True) if len(gray_fields) > 0 else ""
        venue = gray_fields[1].get_text(" ", strip=True) if len(gray_fields) > 1 else ""
        year_node = row.select_one(".gsc_a_y span")
        year = year_node.get_text(" ", strip=True) if year_node else ""
        citation_node = row.select_one(".gsc_a_ac")
        num_citations = parse_int(citation_node.get_text(" ", strip=True) if citation_node else "")

        bib = {
            "title": title_node.get_text(" ", strip=True),
        }
        if authors:
            bib["author"] = authors
        if venue:
            bib["citation"] = venue
        if year:
            bib["pub_year"] = year

        publications[paper_id] = {
            "container_type": "Publication",
            "source": "AUTHOR_PUBLICATION_ENTRY",
            "bib": bib,
            "filled": False,
            "author_pub_id": paper_id,
            "num_citations": num_citations,
        }

    return publications


def build_data(html, scholar_id):
    soup = BeautifulSoup(html, "html.parser")
    stats = parse_stats(soup)
    publications = parse_publications(soup)

    if "citedby" not in stats:
        raise RuntimeError("Could not parse total citation count from Google Scholar")
    if not publications:
        raise RuntimeError("Could not parse publications from Google Scholar")

    data = {
        "name": soup.select_one("#gsc_prf_in").get_text(" ", strip=True)
        if soup.select_one("#gsc_prf_in")
        else "",
        "scholar_id": scholar_id,
        "updated": datetime.now(timezone.utc).isoformat(),
        "publications": publications,
        "cites_per_year": parse_cites_per_year(soup),
    }
    data.update(stats)
    return data


def main():
    scholar_id = os.environ["GOOGLE_SCHOLAR_ID"]
    html = fetch_profile(scholar_id)
    author = build_data(html, scholar_id)

    print(
        f"Parsed Google Scholar profile for {author.get('name') or scholar_id}: "
        f"{author['citedby']} citations, {len(author['publications'])} publications"
    )

    os.makedirs("results", exist_ok=True)
    with open("results/gs_data.json", "w", encoding="utf-8") as outfile:
        json.dump(author, outfile, ensure_ascii=False, indent=2)

    shieldsio_data = {
        "schemaVersion": 1,
        "label": "citations",
        "message": f"{author['citedby']}",
    }
    with open("results/gs_data_shieldsio.json", "w", encoding="utf-8") as outfile:
        json.dump(shieldsio_data, outfile, ensure_ascii=False)


if __name__ == "__main__":
    main()
