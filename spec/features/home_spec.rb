require 'rails_helper'

describe "Home Page" do
  it "renders" do
    visit "/"
    expect(page).to have_content "Valley Fire"
    expect(page).to have_content "Lost and Found"
  end

  it "accepts reports" do
    visit "/"
    click_link "Report"
    expect(current_path).to eq "/reports/new"
  end
end
