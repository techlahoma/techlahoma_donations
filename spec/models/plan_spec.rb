require 'rails_helper'

RSpec.describe Plan, type: :model do

  describe "membership_list" do
    it "should return a list of available plans" do
      plan_bases = Plan::MEMBERSHIP_BASES
      membership_list = Plan.membership_list

      expect(membership_list.count).to eq(plan_bases.count * 2)
    end
  end

end
