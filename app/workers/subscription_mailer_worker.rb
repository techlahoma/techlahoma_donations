class SubscriptionMailerWorker
  include Sidekiq::Worker

  def perform(subscription_id)
    subscription = Subscription.find subscription_id
    SubscriptionMailer.thank_you_email(subscription).deliver
  end
end
