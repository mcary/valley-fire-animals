require 'rails_helper'

describe "Home Page" do
  it "renders" do
    visit "/"
    expect(page).to have_content "Valley Fire"
    expect(page).to have_content "Lost and Found"
  end
end
