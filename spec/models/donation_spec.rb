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

end
