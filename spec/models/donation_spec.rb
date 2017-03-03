require 'rails_helper'

RSpec.describe Donation, type: :model do

  before :each do
    StripeMock.start
  end
  after :each do
    StripeMock.stop
  end

  it "should auto generate a guid on creation" do
    customer = Stripe::Customer.create({
          email: 'johnny@appleseed.com',
          :card => 'valid_card_token'
        })

    donation = Donation.create! first_name: "Jeremy", last_name: "Green", email: "jeremy@octolabs.com", amount: 100.00, token_id: customer.id
    assert !donation.guid.nil?
  end

  describe "csv" do
    it "produces records for each Donation in the DB" do
      donation1 = create :donation, name: 'person1'
      donation2 = create :donation, name: 'person2'
      csv = Donation.to_csv
      expect(csv).to match 'person1'
      expect(csv).to match 'person2'
    end
  end
end
