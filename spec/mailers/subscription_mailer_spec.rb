require "rails_helper"

RSpec.describe SubscriptionMailer, type: :mailer do
  describe "thank_you_email" do
    let(:subscription){ create :subscription }
    let(:mail) { SubscriptionMailer.thank_you_email(subscription) }

    it "renders the headers" do
      expect(mail.subject).to eq("Thanks for subscribing to Techlahoma!")
      expect(mail.to).to eq([subscription.email])
      expect(mail.from).to eq(["donate@techlahoma.org"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("SubscriptionMailer#thank_you_email")
    end
  end
end
