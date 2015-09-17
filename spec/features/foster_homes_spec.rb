require 'rails_helper'

# only registered agencies can request:
# food, supplies, medicine
# need verification/moderation

describe "Foster Homes" do
  
  before do
    create_animal "dog"
    create_animal "cat"
    create_animal "horse"
  end
  
  it "new" do
    visit "/foster_homes/new"
    name = "Foo House"
    address = "123 Bar St. Sebastopol, Ca. 9547"
    fill_in "foster_home_name", with: name
    fill_in "foster_home_address", with: address
    check "foster_home_animal_cat"
    click_on "Create Foster home"
    expect(page).to have_content "Foster home was successfully created"
    expect(page).to have_content "cat"
    expect(page).not_to have_content "dog"
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

  private

  def create_animal(name="Dog")
    visit "/animals/new"
    fill_in "animal_name", with: name
    click_on "Create Animal"
    expect(page).to have_content "Animal was successfully created"
  end
end
