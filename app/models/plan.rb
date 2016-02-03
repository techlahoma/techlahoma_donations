class Plan < ActiveRecord::Base

  INTERVALS = ["day","week","month","year"]

  validates :amount, :numericality => true
  validates :interval, :presence => true
  validates :interval_count, :numericality => true
  validates :name, :presence => true
  validates :stripe_id, :presence => true

  after_create :create_stripe_plan
  def create_stripe_plan
    Stripe::Plan.create({
      :amount => self.amount,
      :interval => self.interval,
      :interval_count => self.interval_count,
      :name => self.name,
      :currency => 'usd',
      :id => self.stripe_id,
      :trial_period_days => 0
    })
  end
end
