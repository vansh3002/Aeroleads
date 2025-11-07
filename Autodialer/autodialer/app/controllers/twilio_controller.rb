# app/controllers/twilio_controller.rb
require 'twilio-ruby'

class TwilioController < ApplicationController
  skip_before_action :verify_authenticity_token

  def voice
    response = Twilio::TwiML::VoiceResponse.new do |r|
      r.say(message: "Hello! This is a test call from your autodialer application.", voice: 'alice', language: 'en-US')
      r.pause(length: 1)
      r.say(message: "You can customize this message anytime from your Rails controller.", voice: 'alice')
    end

    render xml: response.to_s
  end

  def status
    puts "📞 Twilio status update: #{params.inspect}"
    head :ok
  end
end
