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
    donation_saved = @donation.save
    if donation_saved
      DonationMailerWorker.perform_async(@donation.id)
      DonationSlackWorker.perform_async(@donation.id)
    end
    return donation_saved
  end

  def to_model
    return @donation
  end

  def model
    return @donation
  end

  delegate :persisted?, to: :@donation
  delegate :new_record?, to: :@donation
  delegate :errors, to: :@donation
end
