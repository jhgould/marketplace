require 'rails_helper'

RSpec.feature "User can create a listing", type: :feature do 
  let!(:apartment) { create(:apartment, :real_address) }
  let!(:user) { create(:user, apartment_id: apartment.id) }
  scenario "User creates a new listing" do
    
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
    click_link "Create a Listing"
    fill_in "Type", with: "Product"
    fill_in "Title", with: "Test Listing"
    fill_in "Description", with: "This is a test listing"
    fill_in "Price", with: "100"
    click_button "Create Listing"

    # expect(page).to have_content
  end
end