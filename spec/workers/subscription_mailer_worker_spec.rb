require 'rails_helper'
RSpec.describe SubscriptionMailerWorker, type: :worker do
  before :each do
    ActionMailer::Base.deliveries.clear
    Sidekiq::Testing.inline!
  end
  let(:worker){ SubscriptionMailerWorker.new }
  describe "perform" do
    it "should call the mailer" do
      subscription = create :subscription
      worker.perform(subscription.id)
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end
  end
end
