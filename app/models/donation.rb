class Donation < ActiveRecord::Base

  require 'csv'

  include GuidIds

  validates :email, :presence => true

  scope :true_believers, -> { where("created_at < ?",Date.parse("Feb 25, 2016")) }
  scope :in_campaign, -> { where("created_at > ?",Date.parse("Feb 25, 2016")) }


  def donor_name
    self.accept_recognition? ? name : "An Anonymous Donor"
  end

  #before_create :populate_plan_data, :charge_the_token
  after_create :send_thank_you_email, :notify_slack, :notify_techlahomies

  def populate_plan_data
    plan = Plan.find(plan_id)
    return unless plan
    self.plan_name = plan[:name]
    self.amount = plan[:cost_in_dollars_per_year]
    self.plan_type = plan[:type]
  end


  def charge_the_token
    return unless token_id.present?
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

  def send_thank_you_email
    DonationMailer.thank_you_email(self).deliver_later
  end

  def notify_slack
    Chat.slack_message(slack_message)
  end

  def slack_message
    if plan.blank?
      "New Donation: $#{self.amount.to_i} by #{self.donor_name}"
    elsif plan[:type] == "Membership"
      "New Member: #{plan[:name]} - $#{self.amount.to_i} by #{self.donor_name}"
    elsif plan[:type] == "Sponsorship"
      "New Sponsor: #{plan[:name]} - $#{self.amount.to_i} by #{self.donor_name}"
    else
      "Unknown Donation Type: $#{self.amount.to_i} by #{self.donor_name} (How did this even happen!?)"
    end
  end

  def notify_techlahomies
    #p 'email techlahoma@gmail.com about donation posting'
  end

  def plan
    Plan.find(plan_id)
  end

  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |product|
        csv << product.attributes.values_at(*column_names)
      end
    end
  end

end
