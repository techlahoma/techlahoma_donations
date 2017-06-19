class SubscriptionPaymentSlackWorker
  include Sidekiq::Worker

  def perform(donation_id)
    donation = Donation.find donation_id
    message = slack_message(donation)
    Chat.slack_message(message)
  end

  def slack_message(donation)
    "Subscription Payment: $#{donation.amount.to_i} by #{donation.donor_name}"
  end
end
