require "rails_helper"

RSpec.describe SubscriptionPaymentMailer, type: :mailer do
  describe "thank_you_email" do
    let(:subscription){ create :subscription }
    let(:donation){ create :donation, subscription: subscription}
    let(:mail) { SubscriptionPaymentMailer.thank_you_email(donation) }

    it "renders the headers" do
      expect(mail.subject).to eq("Thanks for your monthly donation to Techlahoma!")
      expect(mail.to).to eq([donation.email])
      expect(mail.from).to eq(["donate@techlahoma.org"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Thank you for supporting Techlahoma.")
    end
  end
end
