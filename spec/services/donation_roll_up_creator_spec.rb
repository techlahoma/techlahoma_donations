require 'rails_helper'

RSpec.describe DonationRollUpCreator, type: :service do
  describe "call" do
    before do
      create :donation, email: 'datachomp@techlahoma.org', amount: 10, created_at: (Time.now - 14.months)
      create :donation, email: 'datachomp@techlahoma.org', amount: 40
      create :donation, email: 'datachomp@techlahoma.org', amount: 2
      create :donation, email: 'jgreen@techlahoma.org', amount: 10
      create :donation, email: 'jgreen@techlahoma.org', amount: 5
    end
    it "creates one DonationRollUp for each uniqe email address that has donated" do
      DonationRollUpCreator.call(Time.now.beginning_of_year, Time.now.end_of_year)
      expect(DonationRollUp.count).to eq(2)
      roll_up = DonationRollUp.where(email: 'datachomp@techlahoma.org').first
      expect(roll_up.amount).to eq(42)
    end
  end
end

