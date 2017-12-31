class AddEcwidDiscountCouponCodeToDonationRollUps < ActiveRecord::Migration
  def change
    add_column :donation_roll_ups, :ecwid_discount_coupon_code, :string
  end
end
