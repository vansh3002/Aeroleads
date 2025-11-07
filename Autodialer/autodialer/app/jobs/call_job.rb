class CallJob < ApplicationJob
  queue_as :default

  def perform(number)
    log = CallLog.create(phone_number: number, status: 'queued')
    client = Twilio::REST::Client.new(TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN)
    begin
      call = client.calls.create(
        from: TWILIO_FROM_NUMBER,
        to: number,
        url: "https://demo.twilio.com/docs/voice.xml", # Twilio demo XML
        status_callback_event: ['completed', 'failed'],
        status_callback: "http://localhost:3000/twilio/status"
      )
      log.update(status: 'initiated', twilio_sid: call.sid)
    rescue Twilio::REST::RestError => e
      log.update(status: 'error', message: e.message)
    end
  end
end
