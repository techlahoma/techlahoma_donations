module DonationsHelper

  def donation_gets_a_gift donation
    plan_gets_a_gift(donation.plan) && donation.accept_gift?
  end

  def donation_gets_hoodie donation
    plan_gets_hoodie(donation.plan) &&
      donation.gift_selected.include?("Hoodie")
  end

  def donation_gets_yeti donation
    plan_gets_hoodie(donation.plan) &&
      donation.gift_selected.include?("Yeti")
  end

end
