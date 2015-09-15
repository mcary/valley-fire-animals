require 'rails_helper'

describe "Reports" do
  it "new" do
    visit "reports/new"
    fill_in "Summary", with: "Cat, Cinimon Tortoise Shell"
    fill_in "Description", with: "Found east of Calistoga.  Tags say 'Smith'."
    choose "I found"
    fill_in "Reporter name", with: "Marcel Cary"
    fill_in "Reporter contact info", with: "Tweet at @marcelcary"
    click_button "Create Report"
    expect(page).to have_content "Report was successfully created."

    visit "/reports"
    expect(page).to have_content "Cat, Cinimon Tortoise Shell"
    expect(Report.first.report_type).to eq "found"
  end
end
