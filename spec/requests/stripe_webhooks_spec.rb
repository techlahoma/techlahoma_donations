require 'rails_helper'

describe "Billing Events" do

  #before :each do
    #StripeMock.start
    #@plan_amount = 16
    #@plan_id = SubscriptionPlan.plan_stripe_id(@plan_amount)
    #SubscriptionPlan.create_stripe_plan(@plan_amount)
    ##Plan.create_stripe_plan(@plan)
  #end

  #after :each do
    #StripeMock.stop
  #end

  def stub_event(fixture_id, status = 200)
    stub_request(:get, "https://api.stripe.com/v1/events/#{fixture_id}").
      to_return(status: status, body: File.read("spec/fixtures/#{fixture_id}.json"))
  end

  def create_subscription
    Subscription.create!({
      :stripe_subscription_id => 'sub_42',
      :email => 'test@person.com',
      :stripe_plan_id => @plan_id,
      :token_id => 'xyz'
    })
  end

  describe "invoice.payment.succeeded with a subscription" do
    before do
      expect_any_instance_of(Subscription).to receive(:charge_the_token).and_return(nil)
      stub_event 'invoice_payment_succeeded'
      create_subscription
    end

    it "is successful" do
      post '/stripe_webhooks', id: 'invoice_payment_succeeded'
      expect(response.code).to eq "200"
      expect(Donation.count).to eq 1
      # Additional expectations...
    end
  end
end
