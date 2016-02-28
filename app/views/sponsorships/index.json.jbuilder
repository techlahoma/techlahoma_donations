json.array!(@sponsorships) do |sponsorship|
  json.extract! sponsorship, :id, :email, :name, :amount, :guid, :token_id, :stripe_id, :stripe_status, :stripe_response, :plan_data
  json.url sponsorship_url(sponsorship, format: :json)
end
