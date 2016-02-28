require "rails_helper"

RSpec.describe SponsorshipsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/sponsorships").to route_to("sponsorships#index")
    end

    it "routes to #new" do
      expect(:get => "/sponsorships/new").to route_to("sponsorships#new")
    end

    it "routes to #show" do
      expect(:get => "/sponsorships/1").to route_to("sponsorships#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/sponsorships/1/edit").to route_to("sponsorships#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/sponsorships").to route_to("sponsorships#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/sponsorships/1").to route_to("sponsorships#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/sponsorships/1").to route_to("sponsorships#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/sponsorships/1").to route_to("sponsorships#destroy", :id => "1")
    end

  end
end
