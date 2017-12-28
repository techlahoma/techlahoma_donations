require 'rails_helper'

RSpec.describe "DonationRollUps", type: :request do
  describe "GET /donation_roll_ups" do
    it "works! (now write some real specs)" do
      get donation_roll_ups_path
      expect(response).to have_http_status(200)
    end
  end
end
