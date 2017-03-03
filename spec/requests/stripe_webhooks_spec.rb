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

  

  describe "invoice.payment.succeeded with a subscription" do
    before do
      expect_any_instance_of(Subscription).to receive(:charge_the_token).and_return(nil)
      stub_stripe_event 'invoice_payment_succeeded'
      create :subscription
    end

    it "returns 200 and creates a donation" do
      post '/stripe_webhooks', id: 'invoice_payment_succeeded'
      expect(response.code).to eq "200"
      expect(Donation.count).to eq 1
      # Additional expectations...
    end
  end

  describe "invoice.payment.succeeded without a subscription" do
    before do
      expect_any_instance_of(Subscription).to receive(:charge_the_token).and_return(nil)
      stub_stripe_event 'invoice_payment_succeeded'
      create :subscription, :stripe_subscription_id => 'sub_does_not_exist'
    end

    it "returns 200 and does not create a donation" do
      post '/stripe_webhooks', id: 'invoice_payment_succeeded'
      expect(response.code).to eq "200"
      expect(Donation.count).to eq 0
      # Additional expectations...
    end
  end

end
