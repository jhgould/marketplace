require 'rails_helper'

RSpec.feature "User can create a listing", type: :feature do 
  let!(:apartment) { create(:apartment, :real_address) }
  let!(:user) { create(:user, apartment_id: apartment.id) }
  let!(:category) { create(:category, name: "Kitchen") }
  scenario "User creates a new listing" do

    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
    visit user_dashboard_path
    click_link "Create Listing"
    
    choose "listing_type_productlisting"  # Changed to use the actual radio button ID
    click_button "Next Step"
    
    fill_in "Title", with: "Test Listing"
    fill_in "Description", with: "This is a test listing"
    fill_in "Price", with: "100"
    click_button "Next Step"

    select "Kitchen", from: "product_listing_category_ids"
    click_button "Next Step"

    # Make sure test image exists before attaching
    test_image_path = Rails.root.join("spec/fixtures/files/test_image.jpg")
    raise "Test image not found at #{test_image_path}" unless File.exist?(test_image_path)

    attach_file "product_listing_images", test_image_path
    
    click_button "Finish"
    expect(current_path).to eq(user_dashboard_path)
  end
end