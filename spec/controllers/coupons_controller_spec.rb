require 'rails_helper'

RSpec.describe CouponsController, type: :controller do

  let(:donation_roll_up){ create :donation_roll_up }

  describe "GET #show" do
    it "returns http success" do
      get :show, id: donation_roll_up.guid
      expect(response).to have_http_status(:success)
    end
  end

  #describe "GET #destroy" do
    #it "returns http success" do
      #delete :destroy, id: donation_roll_up.guid
      #expect(response).to redirect_to(coupon_path(donation_roll_up))
      #donation_roll_up.reload
      #expect(donation_roll_up.gift_declined_at).not_to be_nil
    #end
  #end

end
