require 'test_helper'

class DonationsControllerTest < ActionController::TestCase
  setup do
    @donation = donations(:one)
    StripeMock.start
  end
  teardown do
    StripeMock.stop
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:donations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create donation" do

    customer = Stripe::Customer.create({
          email: 'johnny@appleseed.com',
          :card => 'valid_card_token'
        })
        
    assert_difference('Donation.count') do
      post :create, donation: { amount: @donation.amount, email: @donation.email, first_name: @donation.first_name, last_name: @donation.last_name, token_id: customer.id }
    end

    assert_redirected_to donation_path(assigns(:donation))
  end

end
