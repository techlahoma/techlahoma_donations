require 'test_helper'
require 'pp'

class SubscriptionTest < ActiveSupport::TestCase
  setup do
    @client = StripeMock.start_client
    @client.clear_server_data
    @plan = Plan.plan_list.first
    Plan.create_stripe_plan(@plan)
  end
  teardown do
    StripeMock.stop_client
  end
  test "charge_the_token" do
    subscription = Subscription.create(:stripe_plan_id => @plan[:id], :token_id => 'test-token', :email => 'test@test.com')

    customers = @client.get_server_data(:customers)
    assert_equal 1, customers.size
  end

  test "cancel" do
    subscription = Subscription.create(:stripe_plan_id => @plan[:id], :token_id => 'test-token', :email => 'test@test.com')

    subscription.cancel

    customers = @client.get_server_data(:customers)

    assert_equal 'canceled', customers["test_cus_1"][:subscriptions][:data].first[:status]
  end
end
