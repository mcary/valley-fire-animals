require 'rails_helper'

RSpec.describe "FosterHomes", :type => :request do
  describe "GET /foster_homes" do
    it "works! (now write some real specs)" do
      get foster_homes_path
      expect(response.status).to be(200)
    end
  end
end
