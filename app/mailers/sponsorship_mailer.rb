class SponsorshipMailer < ApplicationMailer
  default from: "Techlahoma <donate@techlahoma.org>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.sponsorship_mailer.thank_you_email.subject
  #
  def thank_you_email(sponsorship)
    @sponsorship = sponsorship
    mail(to: @sponsorship.email, subject: 'Thanks for sponsoring Techlahoma!')
  end
end
