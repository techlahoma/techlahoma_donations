require "rails_helper"

RSpec.describe DonationRollUpMailer, type: :mailer do
  describe "thank_you" do
    let(:donation_roll_up){ create :donation_roll_up }
    let(:mail) { DonationRollUpMailer.thank_you(donation_roll_up) }

    it "renders the headers" do
      expect(mail.subject).to eq("A gift from Techlahoma")
      expect(mail.to).to eq([donation_roll_up.email])
      expect(mail.from).to eq(["donate@techlahoma.org"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hey friend, thanks for donating.")
    end
  end

end
