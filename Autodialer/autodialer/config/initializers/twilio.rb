require 'twilio-ruby'
require 'dotenv/load'  # ensures .env is loaded automatically

TWILIO_ACCOUNT_SID = ENV.fetch("TWILIO_ACCOUNT_SID")
TWILIO_AUTH_TOKEN  = ENV.fetch("TWILIO_AUTH_TOKEN")
TWILIO_FROM_NUMBER = ENV.fetch("TWILIO_FROM_NUMBER")

TWILIO_CLIENT = Twilio::REST::Client.new(TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN)