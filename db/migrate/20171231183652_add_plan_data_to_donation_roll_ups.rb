class AddPlanDataToDonationRollUps < ActiveRecord::Migration
  def change
    add_column :donation_roll_ups, :ecwid_discount_coupon_amount, :decimal
    add_column :donation_roll_ups, :plan_cost_in_dollars_per_year, :decimal
    add_column :donation_roll_ups, :plan_name, :string
  end
end
