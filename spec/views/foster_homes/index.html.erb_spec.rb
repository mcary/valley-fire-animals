require 'rails_helper'

RSpec.describe "foster_homes/index", :type => :view do
  before(:each) do
    assign(:foster_homes, [
      FosterHome.create!(
        :name => "Name",
        :address => "Address",
        :details => "MyText"
      ),
      FosterHome.create!(
        :name => "Name",
        :address => "Address",
        :details => "MyText"
      )
    ])
  end

  it "renders a list of foster_homes" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
