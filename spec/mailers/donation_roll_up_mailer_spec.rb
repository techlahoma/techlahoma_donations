require "rails_helper"

RSpec.describe DonationRollUpMailer, type: :mailer do
  describe "thank_you" do
    let(:mail) { DonationRollUpMailer.thank_you }

    it "renders the headers" do
      expect(mail.subject).to eq("Thank you")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
