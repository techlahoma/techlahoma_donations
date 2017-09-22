class Subscription < ActiveRecord::Base

  include GuidIds
  include ActionView::Helpers::NumberHelper # for number_to_currency

  validates :email, :presence => true
  has_many :donations

  def donor_name
    self.accept_recognition? ? name : "An Anonymous Donor"
  end

  def charge_the_token
    customer = Stripe::Customer.create(
      :source => self.token_id,
      :plan => self.stripe_plan_id,
      :email => self.email
    )
    self.stripe_customer_id = customer["id"]
    self.stripe_subscription_id = customer["subscriptions"]["data"].first["id"]
    self.stripe_status = customer["subscriptions"]["data"].first["status"]
    self.stripe_response = customer.to_json
    #self.save!
  end

  def populate_plan_data
    #self.plan_name = plan[:name]
    #self.interval = plan[:interval]
    #self.interval_count = plan[:interval_count]
  end

  def cancel
    customer = Stripe::Customer.retrieve(stripe_customer_id)
    customer.subscriptions.retrieve(stripe_subscription_id).delete
    self.stripe_status = 'canceled'
    self.save
  end

  def canceled?
    stripe_status == 'canceled'
  end

  def plan
    SubscriptionPlan.find_by_stripe_id(stripe_plan_id)
  end

  def friendly_amount
    f_amount = self.amount.present? ? self.amount.to_f / 100 : 0
    return number_to_currency f_amount
  end

end
