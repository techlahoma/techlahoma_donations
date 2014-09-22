json.array!(@donations) do |donation|
  json.extract! donation, :id, :first_name, :last_name, :email, :amount
  json.url donation_url(donation, format: :json)
end
