require 'rails_helper'

# only registered agencies can request:
# food, supplies, medicine
# need verification/moderation

describe "Foster Homes" do
  
  it "new" do
    visit "foster_homes/new"
    save_and_open_page
    expect(page).to have_content "Cat, Cinimon Tortoise Shell"
  end
  
  it "index" do
    visit "foster_homes"
    save_and_open_page
    expect(page).to have_content "Cat, Cinimon Tortoise Shell"
  end
  
  it "show" do
  end
  
  it "has a CTA on the home page" do
    
  end
  # it "edit" do
  # end
end
