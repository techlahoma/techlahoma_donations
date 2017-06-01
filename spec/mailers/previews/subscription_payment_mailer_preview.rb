# Preview all emails at http://localhost:3000/rails/mailers/subscription_payment_mailer
class SubscriptionPaymentMailerPreview < ActionMailer::Preview

  def thank_you_email_of_last_subscriber
    @donation = Donation.where("subscription_id is not null").last
    SubscriptionPaymentMailer.thank_you_email(@donation)
  end

end
