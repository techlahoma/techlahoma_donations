class SubscriptionPlan

  MONTHLY_PLAN_AMOUNTS = [16, 32, 64, 128, 256, 512, 1024, 2048]

  def self.delete_all_stripe_plans
    plans = Stripe::Plan.all
    plans.each do |plan|
      plan.delete
    end
  end

  def self.create_all_stripe_plans
    MONTHLY_PLAN_AMOUNTS.each do |plan_amount|
      create_stripe_plan plan_amount
    end
  end

  def self.create_stripe_plan plan_amount
    Stripe::Plan.create({
      :amount => (plan_amount * 100).to_i,
      :interval => 'month',
      :interval_count => 1,
      :name => "Techlahoma Monthly Membership $#{plan_amount}",
      :currency => 'usd',
      :id => plan_stripe_id(plan_amount),
      :trial_period_days => 0
    })
  end

  def self.plan_stripe_id plan_amount
    "membership-2017-#{plan_amount}"
  end
end
