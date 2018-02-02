class DonationRollUp < ActiveRecord::Base

  require 'csv'

  include GuidIds

  def plan
    return @plan if @plan
    @plan = nil
    Plan::MEMBERSHIP_BASES.each do |plan|
      if plan[:cost_in_dollars_per_year] <= self.amount
        @plan = plan
      end
    end
    return @plan
  end

  before_save :populate_plan_data, on: :create

  def populate_plan_data
    if plan
      self.ecwid_discount_coupon_amount = plan[:ecwid_discount_coupon_amount]
      self.plan_name = plan[:name]
      self.plan_cost_in_dollars_per_year = plan[:cost_in_dollars_per_year]
    else
      self.ecwid_discount_coupon_amount = 0
      self.plan_name = "Less than minimum plan"
      self.plan_cost_in_dollars_per_year = 0
    end
  end


  before_validation :generate_ecwid_discount_coupon_code
  validates :ecwid_discount_coupon_code, presence: true, uniqueness: true

  def generate_ecwid_discount_coupon_code
    # If you're trying to set the ecwid_discount_coupon_code by hand you probably want to
    # know if there's a collision. So we'll allow the uniqueness validation
    # to fail instead of trying to auto-generate a new one.
    if self.ecwid_discount_coupon_code.blank?
      begin
        self.ecwid_discount_coupon_code = Haikunator.haikunate
      end while self.class.where(ecwid_discount_coupon_code: self.ecwid_discount_coupon_code).count > 0
    end
  end

  def ecwid_discount_coupon_code_for_display
    plan.present? ? ecwid_discount_coupon_code : "--"
  end

  def self.to_csv
    CSV.generate do |csv|
      headers = column_names
      headers.push("ecwid_actual_gift_value")
      headers.push("tax_deductible_amount")
      csv << headers
      all.each do |obj|
        row_data = obj.attributes.values_at(*column_names)
        gift_value = obj.plan.present? ? obj.plan[:ecwid_actual_gift_value] : 0
        row_data.push(gift_value)
        row_data.push(obj.gift_declined_at.present? ? obj.amount : obj.amount - gift_value)
        csv << row_data
      end
    end
  end
end
