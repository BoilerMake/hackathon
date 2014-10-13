class Update < ActiveRecord::Base
  def text_sent?
    text_sent
  end

  def should_text?
    should_text
  end

  def send_texts
    @client = Twilio::REST::Client.new
    text_body = body
    if short_message.present?
      text_body = short_message
    end
    Hacker.textees.each do |hacker|
      cell = Phoner::Phone.parse hacker.application.cell_phone
      formatted_cell = cell.format('+%c%a%n')
      @client.messages.create(
        from:  ENV["TWILIO_FROM"],
        to:    formatted_cell,
        body:  text_body
      )
    end

  end
end
