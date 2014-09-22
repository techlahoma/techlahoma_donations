require 'test_helper'

class DonationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "auto_generating_guids" do
    donation = Donation.create! first_name: "Jeremy", last_name: "Green", email: "jeremy@octolabs.com", amount: 100.00
    assert !donation.guid.nil?
  end
end
