json.array!(@subscriptions) do |subscription|
  json.extract! subscription, :id, :email, :plan_id, :amount, :stripe_token
  json.url subscription_url(subscription, format: :json)
end
