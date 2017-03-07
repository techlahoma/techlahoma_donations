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
      :interval => ENV['STRIPE_SUBSCRIPTION_INTERVAL'] || 'month',
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

  def self.membership_list
    @@membership_list ||= generate_membership_list(MONTHLY_PLAN_AMOUNTS)
  end

  def self.generate_membership_list(amount_list)
    all_plans = []
    amount_list.each do |plan_amount|
      all_plans.push({
        :base_name => "Techlahoma Membership",
        :name => "Techlahoma Membership",
        :id => plan_stripe_id(plan_amount),
        :cost_in_dollars => plan_amount,
        :interval => ENV['STRIPE_SUBSCRIPTION_INTERVAL'] || 'month',
        :interval_count => 1,
        :benefits => nil
      })
    end
    return all_plans
  end

  def self.find_by_stripe_id stripe_id
    membership_list.select{|p| p[:id] == stripe_id }.first
  end
end
