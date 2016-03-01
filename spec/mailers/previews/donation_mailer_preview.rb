# Preview all emails at http://localhost:3000/rails/mailers/donation_mailer
class DonationMailerPreview < ActionMailer::Preview

  def thank_you_email_of_last_doner
    @donation = Donation.last
    DonationMailer.thank_you_email(@donation)
  end

end
