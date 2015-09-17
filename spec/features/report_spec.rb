require 'rails_helper'

describe "Reports" do
  it "new" do
    %w(Cat Dog).each { |type| AnimalType.create!(name: type) }
    visit "reports/new"
    fill_in "Summary", with: "Cat, Cinimon Tortoise Shell"
    choose "Dog"
    fill_in "Description", with: "Found east of Calistoga.  Tags say 'Smith'."
    choose "I found"
    fill_in "Reporter name", with: "Marcel Cary"
    fill_in "Reporter contact info", with: "Tweet at @marcelcary"
    click_button "Create Report"
    expect(page).to have_content "Report was successfully created."

    visit "/reports"
    expect(page).to have_content "Cat, Cinimon Tortoise Shell"
    expect(page).to have_content "Dog"
    report = Report.first
    expect(report.report_type).to eq "found"
    expect(report.animal_type).to eq AnimalType.find_by(name: "Dog")
  end

  it "requires fields" do
    visit "reports/new"
    # Fill in nothing.
    click_button "Create Report"
    error_heading = "5 errors prohibited this report from being saved"
    expect(page).to have_content error_heading
    expect(page).to have_content "Report type can't be blank"
    expect(page).to have_content "Summary can't be blank"
    expect(page).to have_content "Reporter name can't be blank"
    expect(page).to have_content "Reporter contact info can't be blank"
    expect(page).to have_content "Animal type can't be blank"
  end

  it "caps summary length" do
    visit "reports/new"
    fill_in "Summary", with: "a" * 41
    click_button "Create Report"
    expect(page).to have_content "Summary is too long"
  end
end
