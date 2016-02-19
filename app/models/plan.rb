class Plan

  PLAN_BASES = [
    {
      :name => "Founding Champion",
      :cost_in_dollars_per_year => 512,
      :benefits => "Techlahoma Founding Member Hoodie or Yeti Mug and Stratified Website Recognition"
    },
    {
      :name => "Founding Leader",
      :cost_in_dollars_per_year => 256,
      :benefits => "Techlahoma Founding Member Polo and Stratified Website Recognition"
    },
    {
      :name => "Founding Member",
      :cost_in_dollars_per_year => 128,
      :benefits => "Techlahoma Founding Member T-Shirt and Stratified Website Recognition"
    }
  ]

  def self.plan_bases
    PLAN_BASES
  end

  def self.plan_list
    @@plan_list ||= generate_plan_list
  end

  def self.id_for_plan_base plan_base, modifier
    "#{plan_base[:name].parameterize}-#{modifier}"
  end

  def self.generate_plan_list
    all_plans = []
    PLAN_BASES.each do |plan_base|
      id_base = plan_base[:name].parameterize
      all_plans.push({
        :name => "#{plan_base[:name]} Annual",
        :id => id_for_plan_base(plan_base,'annual'),
        :cost_in_dollars => plan_base[:cost_in_dollars_per_year],
        :interval => 'year',
        :interval_count => 1,
        :benefits => plan_base[:benefits]
      })
      all_plans.push({
        :name => "#{plan_base[:name]} Monthly",
        :id => id_for_plan_base(plan_base,'monthly'),
        :cost_in_dollars => plan_base[:cost_in_dollars_per_year].to_f / 12,
        :interval => 'month',
        :interval_count => 1,
        :benefits => plan_base[:benefits]
      })
    end
    return all_plans
  end

  def self.find_by_stripe_id stripe_id
    plan_list.select{|p| p[:id] == stripe_id }.first
  end

  def self.delete_all_stripe_plans
    plans = Stripe::Plan.all
    plans.each do |plan|
      plan.delete
    end
  end

  def self.create_all_stripe_plans
    plan_list.each do |plan_data|
      create_stripe_plan plan_data
    end
  end

  def self.create_stripe_plan plan_data
    Stripe::Plan.create({
      :amount => (plan_data[:cost_in_dollars] * 100).to_i,
      :interval => plan_data[:interval],
      :interval_count => plan_data[:interval_count],
      :name => plan_data[:name],
      :currency => 'usd',
      :id => plan_data[:id],
      :trial_period_days => 0
    })
  end
end
