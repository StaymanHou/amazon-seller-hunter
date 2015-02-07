require 'rails_helper'

RSpec.describe "Hunts", :type => :request do
  describe "GET /hunts" do
    it "works! (now write some real specs)" do
      get hunts_path
      expect(response).to have_http_status(200)
    end
  end
end
