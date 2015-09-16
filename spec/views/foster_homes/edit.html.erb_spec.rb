require 'rails_helper'

RSpec.describe "foster_homes/edit", :type => :view do
  before(:each) do
    @foster_home = assign(:foster_home, FosterHome.create!(
      :name => "MyString",
      :address => "MyString",
      :details => "MyText"
    ))
  end

  it "renders the edit foster_home form" do
    render

    assert_select "form[action=?][method=?]", foster_home_path(@foster_home), "post" do

      assert_select "input#foster_home_name[name=?]", "foster_home[name]"

      assert_select "input#foster_home_address[name=?]", "foster_home[address]"

      assert_select "textarea#foster_home_details[name=?]", "foster_home[details]"
    end
  end
end
