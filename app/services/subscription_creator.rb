class SubscriptionCreator
  def initialize subscription_params
    @subscription_params = subscription_params
    @subscription = Subscription.new(@subscription_params)
  end

  def save
    # Ideally the process of charging a card would happen
    # in the bakground and in a service object of some sort.
    # This is the quick and dirty method that doesn't require background workers.
    if @subscription.valid?
      @subscription.populate_plan_data
      @subscription.charge_the_token
    end
    subscription_saved = @subscription.save
    if subscription_saved
      SubscriptionMailerWorker.perform_async(@subscription.id)
      SubscriptionSlackWorker.perform_async(@subscription.id)
    end
    return subscription_saved
  end

  def to_model
    return @subscription
  end

  def model
    return @subscription
  end

  delegate :persisted?, to: :@subscription
  delegate :new_record?, to: :@subscription
end
