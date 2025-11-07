# LinkedIn Profile Scraper & Professional Report Generator

This project automates scraping LinkedIn profile data from a list of URLs or a CSV, extracting detailed professional information, and generating structured reports using a language model (`tinyllama`) via **Ollama**.

---

## Features

### Scraper
- Scrapes LinkedIn profile data including:
  - Name
  - Location
  - About
  - Experience
  - Education
  - Skills
  - Publications
  - Volunteering
- Supports multiple profiles from a CSV or a list of URLs.
- Optional: Save raw HTML of profiles for further analysis.
- Randomized delays and user-agent options to reduce detection.

### Report Generator
- Reads scraped LinkedIn data from CSV.
- Generates a professional report for each profile using **Ollama** with `tinyllama` model.
- Report includes sections:
  1. Executive Summary
  2. Career Timeline
  3. Research & Technical Highlights
  4. Key Skills & Strengths
  5. Education
  6. Final Impression
- Includes personal interests such as Hindi literature, writing poems/songs/stories, and sketching.
- Saves the report in a new CSV alongside the original data.

---

## Requirements

- Python 3.8+
- Pandas
- Selenium
- BeautifulSoup4
- Chrome WebDriver (matching your Chrome version)
- **Ollama CLI** installed with the `tinyllama` model

Install Python dependencies:

```bash
pip install pandas selenium beautifulsoup4
