require 'rails_helper'

RSpec.describe "foster_homes/show", :type => :view do
  before(:each) do
    @foster_home = assign(:foster_home, FosterHome.create!(
      :name => "Name",
      :address => "Address",
      :details => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Address/)
    expect(rendered).to match(/MyText/)
  end
end
