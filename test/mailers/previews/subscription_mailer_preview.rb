# Preview all emails at http://localhost:3000/rails/mailers/subscription_mailer
class SubscriptionMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/subscription_mailer/thank_you_email
  def thank_you_email
    SubscriptionMailer.thank_you_email
  end

end
