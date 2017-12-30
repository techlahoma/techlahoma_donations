namespace :stripe do
  namespace :subscriptions do
    desc "Backfill payments"
    task :backfill_payments => :environment  do
      StripeSubscriptionPaymentBackfiller.call
    end
  end
end

