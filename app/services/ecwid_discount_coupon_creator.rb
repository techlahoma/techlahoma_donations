class EcwidDiscountCouponCreator
  def self.call(donation_roll_up)
    client = EcwidApi::Client.new(ENV['ECWID_STORE_ID'], ENV['ECWID_ACCESS_TOKEN'])
    params = {
      "name": "2017 Membership Thank You for #{donation_roll_up.email} - #{donation_roll_up.plan_name}",
      "code": donation_roll_up.ecwid_discount_coupon_code,
      "discountType": "ABS_AND_SHIPPING",
      "status": "ACTIVE",
      "discount": donation_roll_up.ecwid_discount_coupon_amount,
      "launchDate": "2018-01-01",
      "usesLimit": "SINGLE",
      "repeatCustomerOnly": false,
    }
    response = client.post("discount_coupons", params)
    donation_roll_up.update_attributes({
      ecwid_discount_coupon_id: response.body["id"]
    })
  end
end

