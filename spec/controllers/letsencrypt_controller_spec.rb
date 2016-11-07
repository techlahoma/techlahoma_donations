require 'rails_helper'

RSpec.describe LetsencryptController, type: :controller do

  describe "GET #challenge" do
    it "returns http success" do
      get :challenge
      expect(response).to have_http_status(:success)
    end
  end

end
