class DonationCreator
  def initialize donation_params
    @donation_params = donation_params
    @donation = Donation.new(@donation_params)
  end

  def save
    # Ideally the process of charging a card would happen
    # in the bakground and in a service object of some sort.
    # This is the quick and dirty method that doesn't require background workers.
    if @donation.valid?
      @donation.populate_plan_data
      @donation.charge_the_token
    end
    return @donation.save
  end

  def to_model
    return @donation
  end

  delegate :persisted?, to: :@donation
  delegate :new_record?, to: :@donation
end
