# Preview all emails at http://localhost:3000/rails/mailers/donation_roll_ups
class DonationRollUpMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/donation_roll_up_mailer/thank_you
  def thank_you
    @donation_roll_up = DonationRollUp.last
    DonationRollUpMailer.thank_you(@donation_roll_up)
  end

end
