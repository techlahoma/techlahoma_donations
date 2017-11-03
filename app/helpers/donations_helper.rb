module DonationsHelper

  def donation_gets_a_gift donation
    donation.accept_gift?
  end

  def donation_gets_hoodie donation
    plan_gets_hoodie(donation.plan) &&
      donation.gift_selected.include?("Hoodie")
  end

  def donation_gets_yeti donation
    plan_gets_hoodie(donation.plan) &&
      donation.gift_selected.include?("Yeti")
  end

  def gift_text gifts
    ored_gifts = gifts.map{|g| g.respond_to?(:join) ? g.join("<br/>OR<br/>") : g }
    ored_gifts.join("<br/>AND<br/>").html_safe
  end

  def benefits_text benefits
    benefits.is_a?(String) ? benefits : benefits.join("<br/>AND<br/>").html_safe
  end

  def options_for_donation_select
    amounts = Donation::SUGGESTED_AMOUNTS.map{|amount| [number_to_currency(amount), amount]}
    selected_amount =  params[:donation].present? ? params[:donation][:amount] : nil
    options_for_select(amounts + ['Other'], selected_amount)
  end
end
