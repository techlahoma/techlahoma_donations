class DonationRollUpMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.donation_roll_ups.thank_you.subject
  #
  def thank_you(donation_roll_up)
    @donation_roll_up = donation_roll_up
    mail({
      to: donation_roll_up.email,
      subject: "A gift from Techlahoma"
    })
  end
end
