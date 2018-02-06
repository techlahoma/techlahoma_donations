# Preview all emails at http://localhost:3000/rails/mailers/end_of_year_mailer
class EndOfYearMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/end_of_year_mailer/receipt
  def receipt
    @donation_roll_up = DonationRollUp.second
    EndOfYearMailer.receipt(@donation_roll_up)
  end

end
