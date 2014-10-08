class Donation < ActiveRecord::Base

  def to_param
    guid
  end

  def donor_name
    name.blank? ? "An Anonymous Donor" : name
  end
  # Ideally the process of charging a card would happen
  # in the bakground and in a service object of some sort.
  # This is the quick and dirty method that doesn't require background workers.
  after_create :charge_the_token
  def charge_the_token
    charge = Stripe::Charge.create(
      amount:      (amount * 100).to_i,
      currency:    "usd",
      card:        token_id,
      description: email
    )
  end

  # Ideally this would happen in a background thread.
  # This is the quick and dirty method that doesn't require sidekiq or anyting yet.
  after_create :send_thank_you_email, :notify_slack, :notify_techlahomies
  def send_thank_you_email
    DonationMailer.thank_you_email(self).deliver
  end

  def notify_slack
    Chat.slack_message("New Donation: #{self.amount} by #{self.email}")
  end
  def notify_techlahomies
    p 'email techlahoma@gmail.com about donation posting'
  end

  before_create :populate_guid

  private
  def populate_guid
    self.guid = SecureRandom.uuid()
  end


  

end
