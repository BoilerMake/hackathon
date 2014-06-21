require "rails_helper"

RSpec.describe TeamMailer, :type => :mailer do
  describe "invite_hacker" do
    let(:mail) { TeamMailer.invite_hacker }

    it "renders the headers" do
      expect(mail.subject).to eq("Invite hacker")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
