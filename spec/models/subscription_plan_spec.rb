require 'rails_helper'

RSpec.describe SubscriptionPlan, type: :model do

  before :each do
    @client = StripeMock.start_client
    @client.clear_server_data
  end

  after :each do
    StripeMock.stop_client
  end

  describe "create_stripe_plan" do
    it "should create one plan" do
      SubscriptionPlan.create_stripe_plan 42

      plans = @client.get_server_data(:plans)
      expect(plans.size).to eq(1)
    end
  end

  describe "create_all_stripe_plans" do
    it "should create several plans" do
      SubscriptionPlan.create_all_stripe_plans

      plans = @client.get_server_data(:plans)
      assert_equal plans.size, SubscriptionPlan::MONTHLY_PLAN_AMOUNTS.count
    end
  end

  describe "delete_all_stripe_plans" do
    it "should delete all the plans" do
      SubscriptionPlan.create_stripe_plan 42

      plans = @client.get_server_data(:plans)
      assert_equal plans.size, 1

      SubscriptionPlan.delete_all_stripe_plans

      plans = @client.get_server_data(:plans)
      assert_equal plans.size, 0
    end
  end
end
