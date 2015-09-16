require 'rails_helper'

RSpec.describe "foster_homes/new", :type => :view do
  before(:each) do
    assign(:foster_home, FosterHome.new(
      :name => "MyString",
      :address => "MyString",
      :details => "MyText"
    ))
  end

  it "renders new foster_home form" do
    render

    assert_select "form[action=?][method=?]", foster_homes_path, "post" do

      assert_select "input#foster_home_name[name=?]", "foster_home[name]"

      assert_select "input#foster_home_address[name=?]", "foster_home[address]"

      assert_select "textarea#foster_home_details[name=?]", "foster_home[details]"
    end
  end
end
