require "rails_helper"

RSpec.describe Admin::DonationRollUpsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/donation_roll_ups").to route_to("donation_roll_ups#index")
    end

    it "routes to #new" do
      expect(:get => "/donation_roll_ups/new").to route_to("donation_roll_ups#new")
    end

    it "routes to #show" do
      expect(:get => "/donation_roll_ups/1").to route_to("donation_roll_ups#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/donation_roll_ups/1/edit").to route_to("donation_roll_ups#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/donation_roll_ups").to route_to("donation_roll_ups#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/donation_roll_ups/1").to route_to("donation_roll_ups#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/donation_roll_ups/1").to route_to("donation_roll_ups#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/donation_roll_ups/1").to route_to("donation_roll_ups#destroy", :id => "1")
    end

  end
end
