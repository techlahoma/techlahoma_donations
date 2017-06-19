def stub_stripe_event(fixture_id, status = 200)
  stub_request(:get, "https://api.stripe.com/v1/events/#{fixture_id}").
    to_return(status: status, body: File.read("spec/fixtures/#{fixture_id}.json"))
end
