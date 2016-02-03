json.array!(@plans) do |plan|
  json.extract! plan, :id, :amount, :interval, :name, :stripe_id
  json.url plan_url(plan, format: :json)
end
