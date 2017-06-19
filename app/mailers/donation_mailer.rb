class DonationMailer < ApplicationMailer
  add_template_helper DonationsHelper
  add_template_helper SubscriptionsHelper

  def thank_you_email(donation)
    @donation = donation
    mail(to: @donation.email, subject: 'Thanks for donating to Techlahoma!')
  end
end
