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
    create_foster_home_with_dog
    expect(page).to have_content "Foster home was successfully created"
    expect(page).to have_content "dog"
    expect(page).not_to have_content "cat"
    expect_page_to_not_have_disabled_features
  end
  
  it "index" do
    create_foster_home_with_dog
    visit "/foster_homes"
    expect_page_to_not_have_disabled_features
  end
  
  it "show" do
    create_foster_home_with_dog
    expect_page_to_not_have_disabled_features
  end
  
  it "has a CTA on the home page" do
    
  end
  # it "edit" do
  # end

  private

  def expect_page_to_not_have_disabled_features
    expect(page).not_to have_content "Edit"
    expect(page).not_to have_content "Destroy"
  end

  def create_foster_home_with_dog
    visit "/foster_homes/new"
    name = "Foo House"
    address = "123 Bar St. Sebastopol, Ca. 9547"
    fill_in "foster_home_name", with: name
    fill_in "foster_home_address", with: address
    check "foster_home_animal_dog"
    click_on "Create Foster home"
  end

  def create_animal(name="Dog")
    visit "/animals/new"
    fill_in "animal_name", with: name
    click_on "Create Animal"
    expect(page).to have_content "Animal was successfully created"
  end
end
