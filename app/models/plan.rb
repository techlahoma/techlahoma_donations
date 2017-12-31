class Plan

  MEMBERSHIP_BASES = [
    {
      :name => "Member",
      :id => "member-64",
      :type => "Membership",
      :cost_in_dollars_per_year => 64,
      :gift => ["Small 2017 Techlahoma Supporting Member Coffee Mug"],
      :benefits => "Stratified Website Recognition",
      :image => "small-mug.jpg",
      :ecwid_discount_coupon_amount => 27
    },
    {
      :name => "Member",
      :id => "member-128",
      :type => "Membership",
      :cost_in_dollars_per_year => 128,
      :gift => ["Large 2017 Techlahoma Supporting Member Coffee Mug"],
      :benefits => "Stratified Website Recognition",
      :image => "large-mug.jpg",
      :ecwid_discount_coupon_amount => 45
    },
    {
      :name => " Leader",
      :id => "leader",
      :type => "Membership",
      :cost_in_dollars_per_year => 256,
      :gift => ["Large 2017 Techlahoma Supporting Member Coffee Mug", "10x10 2017 Techlahoma Supporting Member Framed Poster"],
      :benefits => "Stratified Website Recognition",
      :image => "leader2017.jpg",
      :ecwid_discount_coupon_amount => 111
    },
    {
      :name => " Champion",
      :id => "champion",
      :type => "Membership",
      :cost_in_dollars_per_year => 512,
      :gift => ["Large 2017 Techlahoma Supporting Member Coffee Mug", "10x10 2017 Techlahoma Supporting Member Framed Poster", "2017 Techlahoma Supporting Member T-shirt"],
      :benefits => "Stratified Website Recognition",
      :image => "champion2017.jpg",
      :ecwid_discount_coupon_amount => 156
    },
    {
      :name => " Early Adopter",
      :id => "early-adopter",
      :type => "Membership",
      :cost_in_dollars_per_year => 1024,
      :gift => ["Large 2017 Techlahoma Supporting Member Coffee Mug", "10x10 2017 Techlahoma Supporting Member Framed Poster", "2017 Techlahoma Supporting Member T-shirt", "2017 Techlahoma Supporting Member Hoodie"],
      :benefits => "Stratified Website Recognition",
      :image => "early-adopter2017.jpg",
      :ecwid_discount_coupon_amount => 255
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
        "Choose a month to be recognized as User Group Hero in each Techlahoma technology group meeting."
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
        "Recognition at all Tulsa or OKC based Techlahoma technology groups from May 2017 - April 2018"
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
        "Recognition as an Angel Investor at all Techlahoma Technology Group meetings taking place from May 2017 - April 2018. Sponsor can elect to send a representative to speak briefly up to 3 times per Techlahoma Technology Group."
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
end
