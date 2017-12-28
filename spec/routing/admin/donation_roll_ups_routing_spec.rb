require "rails_helper"

RSpec.describe Admin::DonationRollUpsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/donation_roll_ups").to route_to("admin/donation_roll_ups#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/donation_roll_ups/new").to route_to("admin/donation_roll_ups#show", :id => "new")
    end

    it "routes to #show" do
      expect(:get => "/admin/donation_roll_ups/1").to route_to("admin/donation_roll_ups#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/donation_roll_ups/1/edit").not_to be_routable
    end

    it "routes to #create" do
      expect(:post => "/admin/donation_roll_ups").not_to be_routable
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/donation_roll_ups/1").not_to be_routable
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/donation_roll_ups/1").not_to be_routable
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/donation_roll_ups/1").not_to be_routable
    end

  end
end
