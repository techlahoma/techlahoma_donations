class DonationSlackWorker
  include Sidekiq::Worker

  def perform(donation_id)
    donation = Donation.find donation_id
    message = slack_message(donation)
    Chat.slack_message(message)
  end

  def slack_message(donation)
    plan = donation.plan
    if plan.blank?
      "New Donation: $#{donation.amount.to_i} by #{donation.donor_name}"
    elsif plan[:type] == "Membership"
      "New Member: #{plan[:name]} - $#{donation.amount.to_i} by #{donation.donor_name}"
    elsif plan[:type] == "Sponsorship"
      "New Sponsor: #{plan[:name]} - $#{donation.amount.to_i} by #{donation.donor_name}"
    else
      "Unknown Donation Type: $#{donation.amount.to_i} by #{donation.donor_name} (How did this even happen!?)"
    end
  end
end
