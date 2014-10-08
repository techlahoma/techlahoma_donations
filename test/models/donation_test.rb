require 'test_helper'

class DonationTest < ActiveSupport::TestCase
  setup do
    StripeMock.start
  end
  teardown do
    StripeMock.stop
  end 

  test "auto_generating_guids" do
    customer = Stripe::Customer.create({
          email: 'johnny@appleseed.com',
          :card => 'valid_card_token'
        })
    
    donation = Donation.create! first_name: "Jeremy", last_name: "Green", email: "jeremy@octolabs.com", amount: 100.00, token_id: customer.id
    assert !donation.guid.nil?
    
  end

end
