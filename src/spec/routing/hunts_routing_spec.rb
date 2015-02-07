require "rails_helper"

RSpec.describe HuntsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/hunts").to route_to("hunts#index")
    end

    it "routes to #new" do
      expect(:get => "/hunts/new").to route_to("hunts#new")
    end

    it "routes to #show" do
      expect(:get => "/hunts/1").to route_to("hunts#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/hunts/1/edit").to route_to("hunts#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/hunts").to route_to("hunts#create")
    end

    it "routes to #update" do
      expect(:put => "/hunts/1").to route_to("hunts#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/hunts/1").to route_to("hunts#destroy", :id => "1")
    end

  end
end
