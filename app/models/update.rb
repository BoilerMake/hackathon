class Update < ActiveRecord::Base
  def text_sent?
    text_sent
  end

  def should_text?
    should_text
  end

  def send_texts
    client = Twilio::REST::Client.new
    text_body = body
    if short_message.present?
      text_body = short_message
    end
    twilio_errors = 0;
    Hacker.textees.each do |hacker|
      if !Phoner::Phone.valid? hacker.application.cell_phone
        next
      end
      cell = Phoner::Phone.parse hacker.application.cell_phone
      formatted_cell = cell.format('+%c%a%n')
      begin
        client.messages.create(
          from:  ENV["TWILIO_FROM"],
          to:    formatted_cell,
          body:  text_body
        )
      rescue Twilio::REST::RequestError => e
        twilio_errors += 1
        logger.debug e
      end
      return twilio_errors
    end

  end
end
