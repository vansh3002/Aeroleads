# Autodialer & AI Blog Generator

This project includes two main components:

1. **Autodialer** – Automatically call phone numbers and log call details using Twilio.  
2. **AI Blog Generator** – Generate multiple blog posts automatically via AI, accessible in the Rails app.

---

## Features

### Autodialer
- Upload a list of phone numbers via CSV.
- Start/stop automated calls using Twilio integration.
- Log call details such as status, timestamp, and number called.
- AI command interface for controlling call flows and generating dynamic messages.
- Delete and fetch logs as needed.
- Real-time call monitoring.

### AI Blog Generator
- Generate multiple blog articles automatically using AI models (ChatGPT API, Gemini API, or Perplexity PRO).
- Accepts a list of titles or topics and additional details as input.
- Saves generated blog posts in the `/blog` section of the app.
- Accessible at the URL:  
http://localhost:3000/blog

## Requirements

- Ruby on Rails (v6+)
- Node.js & NPM
- Twilio account for calling
- AI API credentials (OpenAI, Gemini, or Perplexity PRO)
- Web browser (for frontend dashboard)

Install Ruby dependencies:

```bash
bundle install
Install Node.js dependencies:

bash
Copy code
npm install
Setup
Twilio Configuration
Set environment variables:

bash
Copy code
export TWILIO_ACCOUNT_SID="your_account_sid"
export TWILIO_AUTH_TOKEN="your_auth_token"
export TWILIO_FROM_NUMBER="your_twilio_number"
AI API Configuration
Set environment variables for the AI API of choice:

bash
Copy code
export OPENAI_API_KEY="your_openai_key"
# or
export GEMINI_API_KEY="your_gemini_key"
Database Setup

bash
Copy code
rails db:create
rails db:migrate
Start the Rails Server

bash
Copy code
rails server
Access the app at http://localhost:3000:

Autodialer: http://localhost:3000/dialer

Blog Generator: http://localhost:3000/blog

Usage
Autodialer
Navigate to /dialer.

Upload a CSV of phone numbers.

Click "Start Call" to initiate calls.

Monitor call logs in real-time.

Use "AI Command" to generate dynamic call messages if needed.

AI Blog Generator
Navigate to /blog.

Enter blog titles or topics along with optional details.

Click "Generate Blog" to create AI-generated posts.

Generated blogs are saved automatically and listed on the /blog page.

CSV Formats
Autodialer
phone_number
+911234567890
+919876543210

Blog Generator
title	details
"Python Tips"	"Include 5 practical tips for beginners"
"AI in Healthcare"	"Focus on recent advancements and case studies"

Notes
Ensure proper API keys are set for Twilio and AI services.

Random delays in calling help prevent spam detection.

AI-generated blogs may require review for correctness and formatting.

Logs and blogs are stored in the database and can be exported if needed.

Example Workflow
Upload phone numbers CSV → start autodialer → check call logs.

Navigate to /blog → enter titles → generate AI content → view/edit generated blogs.

