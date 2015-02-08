require "rails_helper"

RSpec.describe RulesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/rules").to route_to("rules#index")
    end

    it "routes to #edit" do
      expect(:get => "/rules/1/edit").to route_to("rules#edit", :id => "1")
    end

    it "routes to #update" do
      expect(:put => "/rules/1").to route_to("rules#update", :id => "1")
    end

  end
end
