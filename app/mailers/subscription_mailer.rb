class SubscriptionMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.subscription_mailer.thank_you_email.subject
  #
  def thank_you_email(subscription)
    @subscription = subscription
    mail(to: @subscription.email, subject: 'Thanks for subscribing to Techlahoma!')
  end

end
