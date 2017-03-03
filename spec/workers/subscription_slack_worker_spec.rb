require 'rails_helper'
RSpec.describe SubscriptionSlackWorker, type: :worker do
  before :each do
    Sidekiq::Testing.inline!
  end
  let(:worker){ SubscriptionSlackWorker.new }
  describe "perform" do
    it "should call the Chat service" do
      subscription = create :subscription
      expect(Chat).to receive(:slack_message).and_return(nil)
      worker.perform(subscription.id)
    end
  end
end
