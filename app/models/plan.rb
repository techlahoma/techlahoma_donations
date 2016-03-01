class Plan

  MEMBERSHIP_BASES = [
    {
      :name => "Founding Member",
      :id => "founding-member",
      :type => "Membership",
      :cost_in_dollars_per_year => 128,
      :gift => ["Techlahoma Founding Member T-Shirt"],
      :benefits => "Stratified Website Recognition"
    },
    {
      :name => "Founding Leader",
      :id => "founding-leader",
      :type => "Membership",
      :cost_in_dollars_per_year => 256,
      :gift => ["Techlahoma Founding Member Polo"],
      :benefits => "Stratified Website Recognition"
    },
    {
      :name => "Founding Champion",
      :id => "founding-champion",
      :type => "Membership",
      :cost_in_dollars_per_year => 512,
      :gift => ["Techlahoma Founding Member Hoodie", "Techlahoma Founding Member Yeti Mug"],
      :benefits => "Stratified Website Recognition"
    },
    {
      :name => "Founding Early Adopter",
      :id => "founding-early-adopter",
      :type => "Membership",
      :cost_in_dollars_per_year => 1024,
      :gift => ["Techlahoma Founding Member Hoodie", "Techlahoma Founding Member Yeti Mug"],
      :benefits => "Stratified Website Recognition"
    }
  ]

  SPONSOR_BASES = [
    {
      :name => "User Group Hero",
      :type => "Sponsorship",
      :id => "user-group-hero",
      :cost_in_dollars_per_year => 2048,
      :opportunities => 12,
      :gift => nil,
      :benefits => [
        "Stratified Website Recognition",
        "Choose a month to be recognized as User Group Hero of the month in each Techlahoma technology group meeting."
      ]
    },
    {
      :name => "Bootstrap Funder",
      :type => "Sponsorship",
      :id => "bootstrap-funder",
      :cost_in_dollars_per_year => 5120,
      :opportunities => 2,
      :gift => nil,
      :benefits => [
        "Stratified Website Recognition",
        "Recognition at Tulsa or OKC based Techlahoma technology groups from May 2016 - April 2017"
      ]
    },
    {
      :name => "Angel Investor",
      :type => "Sponsorship",
      :id => "angel-investor",
      :cost_in_dollars_per_year => 10240,
      :opportunities => nil,
      :gift => nil,
      :benefits => [
        "Stratified Website Recognition",
        "Recognition as an Angel Investor at all Techlahoma Technology Group meetings taking place from May 2016 - April 2017. Sponsor can elect to send a representative to speak briefly up to 3 times per Techlahoma Technology Group."
      ]
    }
  ]

  def self.membership_bases
    MEMBERSHIP_BASES
  end

  def self.sponsor_bases
    SPONSOR_BASES
  end

  def self.find(id)
    (MEMBERSHIP_BASES + SPONSOR_BASES).select{|p| p[:id] == id }.first
  end

  def self.membership_list
    @@membership_list ||= generate_membership_list(MEMBERSHIP_BASES)
  end

  def self.id_for_plan_base plan_base, modifier
    "#{plan_base[:name].parameterize}-#{modifier}"
  end

  def self.generate_membership_list(base_list)
    all_plans = []
    base_list.each do |plan_base|
      all_plans.push({
        :base_name => plan_base[:name],
        :name => "#{plan_base[:name]} Annual",
        :id => id_for_plan_base(plan_base,'annual'),
        :cost_in_dollars => plan_base[:cost_in_dollars_per_year],
        :interval => 'year',
        :interval_count => 1,
        :benefits => plan_base[:benefits]
      })
      all_plans.push({
        :base_name => plan_base[:name],
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
    membership_list.select{|p| p[:id] == stripe_id }.first
  end

  def self.delete_all_stripe_plans
    plans = Stripe::Plan.all
    plans.each do |plan|
      plan.delete
    end
  end

  def self.create_all_stripe_plans
    membership_list.each do |plan_data|
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
