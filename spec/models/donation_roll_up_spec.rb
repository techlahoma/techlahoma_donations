require 'rails_helper'

RSpec.describe DonationRollUp, type: :model do
  describe "#populate_plan_data" do
    Plan::MEMBERSHIP_BASES.each do |plan|
      it "should correctly assign the #{plan[:name]} #{plan[:cost_in_dollars_per_year]} plan" do
        dru = create :donation_roll_up, amount: plan[:cost_in_dollars_per_year] + 1
        expect(dru.plan_name).to eq(plan[:name])
        expect(dru.plan_cost_in_dollars_per_year).to eq(plan[:cost_in_dollars_per_year])
        expect(dru.ecwid_discount_coupon_amount).to eq(plan[:ecwid_discount_coupon_amount])
      end
    end
  end

  describe "before_validation" do
    it "should auto-generate a ecwid_discount_coupon_code" do
      donation_roll_up = create :donation_roll_up
      expect(donation_roll_up.ecwid_discount_coupon_code).not_to be_nil
    end

    it "should keep trying to generate new names until there isn't a collision" do
      name1 = 'black-star-2016'
      name2 = 'blue-dynamite-1234'
      expect(Haikunator).to receive(:haikunate).and_return(name1, name1, name2)
      donation_roll_up = create :donation_roll_up
      expect(DonationRollUp.count).to eq(1)
      expect(donation_roll_up.ecwid_discount_coupon_code).to eq(name1)
      donation_roll_up = create :donation_roll_up
      expect(DonationRollUp.count).to eq(2)
      expect(donation_roll_up.ecwid_discount_coupon_code).to eq(name2)
    end
  end

  describe "ecwid_discount_coupon_code validation" do
    it "should fail validation if the name is not unique" do
      ecwid_discount_coupon_code = 'black-star-2016'
      create :donation_roll_up, ecwid_discount_coupon_code: ecwid_discount_coupon_code
      donation_roll_up = build :donation_roll_up, ecwid_discount_coupon_code: ecwid_discount_coupon_code
      expect(donation_roll_up.valid?).to be_falsey
    end
  end
end
