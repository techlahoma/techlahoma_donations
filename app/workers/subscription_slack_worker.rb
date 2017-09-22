class SubscriptionSlackWorker
  include Sidekiq::Worker

  def perform(subscription_id)
    subscription = Subscription.find subscription_id
    message = slack_message(subscription)
    Chat.slack_message(message)
  end

  def slack_message(subscription)
    plan = subscription.plan
    if plan.blank?
      "New Subscription: #{subscription.friendly_amount} by #{subscription.donor_name}"
    elsif plan[:type] == "Membership"
      "New Member Subscription: #{plan[:name]} - #{subscription.friendly_amount} by #{subscription.donor_name}"
    elsif plan[:type] == "Sponsorship"
      "New Sponsor Subscription: #{plan[:name]} - #{subscription.friendly_amount} by #{subscription.donor_name}"
    else
      "Unknown Subscription Type: #{subscription.friendly_amount} by #{subscription.donor_name} (How did this even happen!?)"
    end
  end
end
