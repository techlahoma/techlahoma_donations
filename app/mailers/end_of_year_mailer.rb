class EndOfYearMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.end_of_year_mailer.receipt.subject
  #
  def receipt(donation_roll_up)
    @donation_roll_up = donation_roll_up
    @donations = Donation.where(email: donation_roll_up.email)
                         .where("created_at > ? and created_at < ?", donation_roll_up.start_time, donation_roll_up.end_time)
                         .order("created_at asc")
    mail({
      to: donation_roll_up.email,
      subject: "Your 2018 Techlahoma Donation Tax Receipt"
    })
  end
end
