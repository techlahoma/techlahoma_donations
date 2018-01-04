class EcwidDiscountCouponDestroyer
  def self.call(donation_roll_up)
    if donation_roll_up.ecwid_discount_coupon_id.present?
      client = EcwidApi::Client.new(ENV['ECWID_STORE_ID'], ENV['ECWID_ACCESS_TOKEN'])
      client.delete("discount_coupons/#{donation_roll_up.ecwid_discount_coupon_id}")
    end
    donation_roll_up.update_attributes({
      gift_declined_at: Time.now
    })
  end
end

