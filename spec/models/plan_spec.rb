require 'rails_helper'

RSpec.describe Plan, type: :model do

  before :each do
    @client = StripeMock.start_client
    @client.clear_server_data
  end

  after :each do
    StripeMock.stop_client
  end

  describe "membership_list" do
    it "should return a list of available plans" do
      plan_bases = Plan::MEMBERSHIP_BASES
      membership_list = Plan.membership_list

      expect(membership_list.count).to eq(plan_bases.count * 2)
    end
  end

  describe "create_stripe_plan" do
    it "should create one plan" do
      plan_data = Plan.membership_list.first
      Plan.create_stripe_plan plan_data

      plans = @client.get_server_data(:plans)
      expect(plans.size).to eq(1)
    end
  end

  describe "create_all_stripe_plans" do
    it "should create several plans" do
      Plan.create_all_stripe_plans

      plans = @client.get_server_data(:plans)
      assert_equal plans.size, Plan.membership_list.count
    end
  end

  describe "delete_all_stripe_plans" do
    it "should delete all the plans" do
      plan_data = Plan.membership_list.first
      Plan.create_stripe_plan plan_data

      plans = @client.get_server_data(:plans)
      assert_equal plans.size, 1

      Plan.delete_all_stripe_plans

      plans = @client.get_server_data(:plans)
      assert_equal plans.size, 0
    end
  end
end
