require 'rails_helper'
require 'pp'

RSpec.describe Subscription, type: :model do
  before :each do
    @client = StripeMock.start_client
    @client.clear_server_data
    SubscriptionPlan.create_stripe_plan(42)
    @plan_id = SubscriptionPlan.plan_stripe_id(42)
    @card_token = StripeMock.generate_card_token(last4: "9191", exp_year: 1984)
  end
  after :each do
    StripeMock.stop_client
  end

  describe "charge_the_token" do
    it "should work" do
      subscription = Subscription.create(:stripe_plan_id => @plan_id, :token_id => @card_token, :email => 'test@test.com')

      customers = @client.get_server_data(:customers)
      assert_equal 1, customers.size

      customer_key = customers.keys.first
      assert_equal 1, customers[customer_key][:subscriptions][:data].length
    end
  end

  describe "cancel" do
    it "should work" do
      subscription = Subscription.create(:stripe_plan_id => @plan_id, :token_id => @card_token, :email => 'test@test.com')

      subscription.cancel

      customers = @client.get_server_data(:customers)
      customer_key = customers.keys.first
      assert_equal 0, customers[customer_key][:subscriptions][:data].length
    end
  end

end
