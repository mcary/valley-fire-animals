require "rails_helper"

RSpec.describe FosterHomesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/foster_homes").to route_to("foster_homes#index")
    end

    it "routes to #new" do
      expect(:get => "/foster_homes/new").to route_to("foster_homes#new")
    end

    it "routes to #show" do
      expect(:get => "/foster_homes/1").to route_to("foster_homes#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/foster_homes/1/edit").to route_to("foster_homes#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/foster_homes").to route_to("foster_homes#create")
    end

    it "routes to #update" do
      expect(:put => "/foster_homes/1").to route_to("foster_homes#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/foster_homes/1").to route_to("foster_homes#destroy", :id => "1")
    end

  end
end
