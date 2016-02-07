require 'test_helper'
require 'pp'

class SubscriptionTest < ActiveSupport::TestCase
  setup do
    @client = StripeMock.start_client
    @client.clear_server_data
  end
  teardown do
    StripeMock.stop_client
  end
  test "charge_the_token" do
    plan = Plan.create(:amount => 1000, :interval => 'day', :name => 'test plan', :stripe_id => 'test_plan')
    subscription = Subscription.create(:plan => plan, :token_id => 'test-token', :email => 'test@test.com')

    customers = @client.get_server_data(:customers)
    assert_equal 1, customers.size
  end

  test "cancel" do
    plan = Plan.create(:amount => 1000, :interval => 'day', :name => 'test plan', :stripe_id => 'test_plan')
    subscription = Subscription.create(:plan => plan, :token_id => 'test-token', :email => 'test@test.com')

    subscription.cancel

    customers = @client.get_server_data(:customers)
    
    assert_equal 'canceled', customers["test_cus_1"][:subscriptions][:data].first[:status]
  end
end
