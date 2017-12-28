json.extract! donation_roll_up, :id, :email, :amount, :start_time, :end_time, :created_at, :updated_at
json.url donation_roll_up_url(donation_roll_up, format: :json)
