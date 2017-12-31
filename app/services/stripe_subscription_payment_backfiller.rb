class StripeSubscriptionPaymentBackfiller
  def self.call
    stripe_subscriptions = Stripe::Subscription.list
    handle_subscription_batch(stripe_subscriptions)
    while(stripe_subscriptions.has_more?)
      last_subscription_id = stripe_subscriptions.to_a.last.id
      stripe_subscriptions = Stripe::Subscription.list(starting_after: last_subscription_id)
      handle_subscription_batch(stripe_subscriptions)
    end
    return nil # prevent noisy output
  end

  def self.handle_subscription_batch(stripe_subscriptions)
    stripe_subscriptions.each do |stripe_subscription|
      handle_single_subscription(stripe_subscription)
    end
  end

  def self.handle_single_subscription(stripe_subscription)
    puts "handling Stripe::Subscription #{stripe_subscription.id}"
    local_sub = Subscription.find_by(stripe_subscription_id: stripe_subscription.id)
    if local_sub.present?
      stripe_invoices = Stripe::Invoice.list(limit: 100, subscription: stripe_subscription.id)
      puts "stripe_invoices.count = #{stripe_invoices.count}"
      puts "local_sub.donations.count = #{local_sub.donations.count}"
      handle_invoice_batch(stripe_invoices, local_sub)
      while(stripe_invoices.has_more?)
        last_invoice_id = stripe_invoices.to_a.last.id
        stripe_invoices = Stripe::Invoice.list(limit: 100, subscription: stripe_subscription.id, starting_after: last_invoice_id)
        handle_invoice_batch(stripe_invoices)
      end
    else
      puts "------------------------------------------------------------"
      puts "missing local subscriptions for #{stripe_subscription.id}"
      cust = Stripe::Customer.retrieve(stripe_subscription.customer)
      puts "customer email = #{cust.email}"
      puts "------------------------------------------------------------"
    end
  end

  def self.handle_invoice_batch(stripe_invoices, local_sub)
    stripe_invoices.each do |stripe_invoice|
      puts "  handling Stripe::Invoice #{stripe_invoice.id}"
      if stripe_invoice.paid?
        charge = Stripe::Charge.retrieve stripe_invoice.payment
        donation = Donation.find_by(stripe_id: charge.id)
        if charge.paid? && !charge.refunded?
          if donation.present?
            puts "    found a donation!"
          else
            puts "    need to create a donation!"
            donation = StripeInvoicePaymentSucceeded.new.create_donation(local_sub, stripe_invoice)
            donation.created_at = Time.at(charge.created)
            donation.notes = "StripeSubscriptionPaymentBackfiller"
            donation.save!
          end
        end
      end
    end
  end
end
