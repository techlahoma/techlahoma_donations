class StripeInvoicePaymentSucceeded
  def call(event)
    Rails.logger.debug "Stripe Event: #{event.to_json}"
    donation = create_donation_from_event(event)

    unless donation
      Rails.logger.info "StripeInvoicePaymentSucceeded did not make a donation"
      Rails.logger.info "StripeInvoicePaymentSucceeded finished"
      return
    end

    donation.save!
    SubscriptionPaymentMailerWorker.perform_async(donation.id)
    SubscriptionPaymentSlackWorker.perform_async(donation.id)
    Rails.logger.info "Stripe Event: StripeInvoicePaymentSucceeded finished"
    return donation
  end

  def create_donation_from_event(event)
    invoice = event.data.object
    subscription = Subscription.find_by!(stripe_subscription_id: invoice.subscription)
    donation = create_donation(subscription, invoice)
    return donation
  rescue ActiveRecord::RecordNotFound
    # we couldn't find a subscription to match up with this invoice
    return nil
  end

  def create_donation(subscription, invoice)
    Donation.new do |d|
      d.email = subscription.email
      d.subscription_id = subscription.id
      d.token_id = 'invoice'
      d.amount = invoice.total.to_f / 100 # we store decimal
    end
  end
end
