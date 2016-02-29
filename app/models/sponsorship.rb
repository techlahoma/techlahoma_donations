class Sponsorship < ActiveRecord::Base

  PLANS = [
    {
      :name => "User Group Hero",
      :type => "Sponsorship",
      :id => "user-group-hero",
      :cost_in_dollars_per_year => 2048,
      :opportunities => 12,
      :gift => nil,
      :benefits => [
        "Website Stratified Recognition props",
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
        "Website Stratified Recognition props",
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
        "Website Stratified Recognition props",
        "Recognition as an Angel Investor at all Techlahoma Technology Group meetings taking place from May 2016 - April 2017. Sponsor can elect to send a representative to speak briefly up to 3 times per Techlahoma Technology Group."
      ]
    }
  ]

  def self.find_plan id
    PLANS.select{|p| p[:id] == id }.first
  end

  validates :email, :presence => true
  validates :name, :presence => true

  def donor_name
    self.accept_recognition? ? name : "An Anonymous Donor"
  end

  # Ideally the process of charging a card would happen
  # in the bakground and in a service object of some sort.
  # This is the quick and dirty method that doesn't require background workers.
  before_create :populate_plan_data, :charge_the_token
  after_create :send_thank_you_email, :notify_slack, :notify_techlahomies
  def charge_the_token
    charge = Stripe::Charge.create(
      amount:      (amount * 100).to_i,
      currency:    "usd",
      card:        token_id,
      description: email
    )
    self.stripe_id = charge["id"]
    self.stripe_status = charge["status"]
    self.stripe_response = charge.to_json
  end

  def populate_plan_data
    #self.plan_name = plan[:name]
    self.amount = plan[:cost_in_dollars_per_year]
  end

  def send_thank_you_email
    SponsorshipMailer.thank_you_email(self).deliver_later
  end

  def notify_slack
    Chat.slack_message("New Sponsorship: $#{self.amount.to_i} by #{self.donor_name}")
  end

  def notify_techlahomies
    #p 'email techlahoma@gmail.com about subscription posting'
  end

  def plan
    Sponsorship.find_plan(plan_id)
  end

end
