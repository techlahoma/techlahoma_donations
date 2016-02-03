require 'test_helper'

class PlanTest < ActiveSupport::TestCase
  setup do
    @client = StripeMock.start_client
    @client.clear_server_data
  end
  teardown do
    StripeMock.stop_client
  end
  test "create_stripe_plan" do
    plan = Plan.new(:amount => 1000, :interval => 'day', :name => 'test plan', :stripe_id => 'test_plan')
    plan.create_stripe_plan

    plans = @client.get_server_data(:plans)
    assert_equal plans.size, 1
  end
end
