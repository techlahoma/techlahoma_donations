require 'test_helper'

class PlanTest < ActiveSupport::TestCase
  setup do
    @client = StripeMock.start_client
    @client.clear_server_data
  end
  teardown do
    StripeMock.stop_client
  end
  

  test "plan_list" do
    plan_bases = Plan::PLAN_BASES
    plan_list = Plan.plan_list

    assert_equal plan_list.count, plan_bases.count * 2
  end

  test "create_stripe_plan" do
    plan_data = Plan.plan_list.first
    Plan.create_stripe_plan plan_data

    plans = @client.get_server_data(:plans)
    assert_equal plans.size, 1
  end

  test "create_all_stripe_plans" do
    Plan.create_all_stripe_plans

    plans = @client.get_server_data(:plans)
    assert_equal plans.size, Plan.plan_list.count
  end

  test "delete_all_stripe_plans" do
    plan_data = Plan.plan_list.first
    Plan.create_stripe_plan plan_data

    plans = @client.get_server_data(:plans)
    assert_equal plans.size, 1

    Plan.delete_all_stripe_plans

    plans = @client.get_server_data(:plans)
    assert_equal plans.size, 0
  end
end
