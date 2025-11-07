# Project Overview

This project is a multi-functional automation toolkit with two main modules:

1. **Autodialer** – A web interface that combines:
   - **Dialer:** Upload phone numbers and make automated calls using Twilio.
   - **Blog Generator:** Generate AI-powered blogs from provided titles and descriptions.

2. **LinkedIn Scraper** – A Python-based scraper to collect LinkedIn profile data:
   - `check.ipynb` contains the scraping logic.
   - `README.md` explains how to use it.
   - `linkedin_profiles.csv` stores the input URLs and scraped profile data.

---

## Project Structure

root/
│
├── autodialer/ # Web interface combining both dialer and blog generator
│ ├── dialer/ # Automated calling scripts (Twilio integration)
│ └── blog/ # AI-powered blog generator
│ ├── README.md # Instructions for autodialer usage
│
├── linked_in_scraper/ # LinkedIn scraping module
│ ├── check.ipynb # Scraper logic
│ ├── linkedin_profiles.csv # Input URLs and scraped data
│ └── README.md # Instructions for scraper usage
│
├── README.md # Project overview and setup instructions
├── requirements.txt # Python dependencies
└── .env # Environment variables (Twilio & AI API keys)
