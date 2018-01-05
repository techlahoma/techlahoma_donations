namespace :donation_roll_ups do
  namespace :email do
    desc "Activate coupon codes for DonationRollUps"
    task :coupons => :environment do
      DonationRollUp.where("ecwid_discount_coupon_amount > 0").find_each do |dru|
        DonationRollUpMailer.thank_you(dru).deliver_now
      end
    end
  end
end

