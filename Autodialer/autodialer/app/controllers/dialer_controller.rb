# app/controllers/dialer_controller.rb
require 'net/http'
require 'json'
require 'uri'

class DialerController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    @phone_numbers = PhoneNumber.all.limit(100)
    @call_logs = CallLog.order(created_at: :desc).limit(200)
  end

def upload_numbers
  numbers_text = params[:numbers_text].to_s
  numbers_text = params[:file].read if params[:file].present?

  # Extract phone-like patterns (7–15 digits)
  raw_numbers = numbers_text.scan(/\+?\d{7,15}/).flatten.uniq

  count = 0
  raw_numbers.each do |num|
    normalized = num.start_with?('+') ? num : "+91#{num}" # add +91 if missing
    PhoneNumber.find_or_create_by(number: normalized)
    count += 1
  end

  redirect_to root_path, notice: "Uploaded #{count} valid numbers."
end


  def start_calls
    to_call = PhoneNumber.limit(100).pluck(:number)
    to_call.each_with_index { |num, idx| CallJob.set(wait: idx.seconds).perform_later(num) }
    redirect_to root_path, notice: "Queued #{to_call.size} calls."
  end

  # 🌟 Universal AI command (Gemini)
  def ai_command
    if request.format.json? || params[:prompt].present?
      begin
        data = request.body.read.presence ? JSON.parse(request.body.read) : {}
        prompt = data["prompt"] || params[:prompt].to_s.strip

        if prompt.blank?
          return render json: { result: "No prompt provided." }, status: 400
        end

        api_key = ENV['GEMINI_API_KEY']
        if api_key.blank?
          return render json: { result: "Gemini API key not set." }, status: 500
        end

        uri = URI("https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=#{api_key}")

        payload = {
          contents: [{ parts: [{ text: prompt }] }],
          temperature: 0.2,
          maxOutputTokens: 800
        }

        # Proper HTTPS request
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        request = Net::HTTP::Post.new(uri.request_uri, "Content-Type" => "application/json")
        request.body = payload.to_json

        response = http.request(request)
        json_res = JSON.parse(response.body)

        # Extract generated text safely
        content = json_res.dig("candidates", 0, "content", "parts", 0, "text") || "No response from Gemini."

        render json: { result: content }
      rescue JSON::ParserError
        render json: { result: "Invalid JSON request." }, status: 400
      rescue => e
        Rails.logger.error("Gemini AI Error: #{e.message}")
        render json: { result: "Error: #{e.message}" }, status: 500
      end
    else
      # Existing dialer call logic
      text = params[:ai_text].to_s.strip.downcase
      if text =~ /(?:make\s+)?call(?:\s+to)?\s+(\+?\d{6,15})/
        number = $1
        CallJob.perform_later(number)
        render json: { result: "Initiating call to #{number} — check logs below for updates." }
      else
        render json: { result: "Could not understand — try: 'make a call to 1800123456'." }, status: 400
      end
    end
  end

  def delete_logs
    CallLog.delete_all
    redirect_to root_path, notice: "All call logs have been deleted."
  end

  def fetch_logs
    @call_logs = CallLog.order(created_at: :desc).limit(200)
    render json: @call_logs.as_json(only: [:phone_number, :status, :message])
  end
end
