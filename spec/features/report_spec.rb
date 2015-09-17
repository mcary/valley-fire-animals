require 'rails_helper'

describe "Reports" do
  it "new" do
    create_report
    visit "/reports"
    expect(page).to have_content "Cat, Cinimon Tortoise Shell"
    expect(Report.first.report_type).to eq "found"
  end

  it "requires fields" do
    visit "reports/new"
    # Fill in nothing.
    click_button "Create Report"
    error_heading = "4 errors prohibited this report from being saved"
    expect(page).to have_content error_heading
    expect(page).to have_content "Report type can't be blank"
    expect(page).to have_content "Summary can't be blank"
    expect(page).to have_content "Reporter name can't be blank"
    expect(page).to have_content "Reporter contact info can't be blank"
  end

  it "caps summary length" do
    visit "reports/new"
    fill_in "Summary", with: "a" * 41
    click_button "Create Report"
    expect(page).to have_content "Summary is too long"
  end
  
  describe "show" do
    it 'can be marked reunited' do
      create_report
      visit "/reports/1"
      expect(page).to have_link "Reunited"
      click_link("Reunited")
      expect(page).to have_content "Congratulations"
      visit "/reports/1"
      expect(page).to have_content "This animal has been returned home :)"
    end
  end
  
  private
  
  def create_report
    visit "reports/new"
    fill_in "Summary", with: "Cat, Cinimon Tortoise Shell"
    fill_in "Description", with: "Found east of Calistoga.  Tags say 'Smith'."
    choose "I found"
    fill_in "Reporter name", with: "Marcel Cary"
    fill_in "Reporter contact info", with: "Tweet at @marcelcary"
    click_button "Create Report"
    expect(page).to have_content "Report was successfully created."
  end
end
