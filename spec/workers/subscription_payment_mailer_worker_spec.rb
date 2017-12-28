require 'rails_helper'
RSpec.describe SubscriptionPaymentMailerWorker, type: :worker do
  before :each do
    ActionMailer::Base.deliveries.clear
    Sidekiq::Testing.inline!
  end
  let(:worker){ SubscriptionPaymentMailerWorker.new }
  let(:subscription){ create :subscription }
  let(:donation){ create :donation, subscription: subscription}
  describe "perform" do
    it "should call the mailer" do
      worker.perform(donation.id)
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end
  end
end
