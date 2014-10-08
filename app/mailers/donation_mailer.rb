class DonationMailer < ActionMailer::Base
  default from: "Techlahoma <donate@techlahoma.org>"

  def thank_you_email(donation)
    @donation = donation
    mail(to: @donation.email, subject: 'Thanks for donating to Techlahoma!')
  end
end
