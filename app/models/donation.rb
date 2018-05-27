class Donation < ActiveRecord::Base

  require 'csv'

  include GuidIds

  validates :email, :presence => true

  scope :true_believers, -> { where("created_at < ?",Date.parse("Feb 25, 2016")) }
  scope :in_campaign, -> { where("created_at > ?",Date.parse("Feb 25, 2016")) }

  belongs_to :subscription

  SUGGESTED_AMOUNTS = [16,32,64,128,256,512,1024,2048,4096]

  def donor_name
    self.accept_recognition? ? name : "An Anonymous Donor"
  end

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
      description: "Website donation from #{name} #{email}"
    )
    self.stripe_id = charge["id"]
    self.stripe_status = charge["status"]
    self.stripe_response = charge.to_json
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
