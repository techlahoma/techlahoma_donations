class StripeInvoicePaymentSucceeded
  def call(event)
    puts "------------ handling event in StripeInvoicePaymentSucceeded ------------"
    Rails.logger.debug "Stripe Event: #{event.to_json}"
    donation = create_donation_from_event(event)

    unless donation
      Rails.logger.info "StripeInvoicePaymentSucceeded did not make a donation"
      Rails.logger.info "StripeInvoicePaymentSucceeded finished"
      return
    end

    donation.save!
    Rails.logger.info "Stripe Event: StripeInvoicePaymentSucceeded finished"
    return donation
  end

  def create_donation_from_event(event)
    invoice = event.data.object

    return unless invoice.charge

    subscription = Subscription.find_by!(stripe_subscription_id: invoice.subscription)

    #stripe_sub = Stripe::Customer.retrieve(subscription.stripe_customer_id).subscriptions.retrieve(invoice.subscription)

    #subscription.sync_with!(stripe_sub)

    donation = create_donation(subscription, invoice)

    #charge = Stripe::Charge.retrieve(invoice.charge, access_token)

    #update_donation_with_charge(donation, charge, access_token)

    return donation
  end

  def create_donation(subscription, invoice)
    Donation.new do |d|
      d.email = subscription.email
      #d.livemode = subscription.livemode
      d.subscription_id = subscription.id
      #s.state = 'processing'
      #s.owner = subscription
      #s.product = subscription.plan
      d.token_id = 'invoice'
      d.amount = invoice.total.to_f / 100 # we store decimal
      #d.currency = invoice.currency
    end
  end

  #def update_donation_with_charge(donation, charge, secret_key)
    #donation.stripe_id  = charge.id
    #donation.card_type  = charge.source.brand
    #donation.card_last4 = charge.source.last4
  #end

end
