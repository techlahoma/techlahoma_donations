class DonationMailerWorker
  include Sidekiq::Worker

  def perform(donation_id)
    donation = Donation.find donation_id
    DonationMailer.thank_you_email(donation).deliver_later
  end
end
