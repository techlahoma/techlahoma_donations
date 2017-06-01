class SubscriptionPaymentMailerWorker
  include Sidekiq::Worker

  def perform(donation_id)
    donation = Donation.find donation_id
    SubscriptionPaymentMailer.thank_you_email(donation).deliver
  end
end
