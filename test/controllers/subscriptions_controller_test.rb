require 'test_helper'

class SubscriptionsControllerTest < ActionController::TestCase
  setup do
    StripeMock.start
    @plan = Plan.plan_list.first
    @subscription = subscriptions(:one)
    Chat.stubs(:slack_message).returns(true)
  end
  teardown do
    StripeMock.stop
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:subscriptions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create subscription" do
    card_token = StripeMock.generate_card_token({})
    Plan.create_stripe_plan(@plan)
    assert_difference('Subscription.count') do
      post :create, subscription: { stripe_plan_id: @plan[:id], amount: @subscription.amount, email: @subscription.email, token_id: card_token }
    end

    assert_redirected_to subscription_path(assigns(:subscription))
  end

  test "should show subscription" do
    get :show, id: @subscription.guid
    assert_response :success
  end

  test "should cancel the subscription without destroying it" do
    Plan.create_stripe_plan(@plan)
    @subscription.charge_the_token
    @subscription.save
    assert_difference('Subscription.count', 0) do
      delete :destroy, id: @subscription
    end

    assert_redirected_to @subscription
  end
end
