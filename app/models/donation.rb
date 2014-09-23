class Donation < ActiveRecord::Base

  def to_param
    guid
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

  before_create :populate_guid

  private
  def populate_guid
    self.guid = SecureRandom.uuid()
  end


  

end
