require 'rails_helper'

RSpec.feature "User can manage their listings (view, update, delete etc)", type: :feature do 
  let!(:apartment) { create(:apartment, :real_address) }
  let!(:user) { create(:user, apartment_id: apartment.id) }
  let!(:category) { create(:category, name: "Kitchen") }
  let!(:listing) { create(:listing, apartment: apartment, user: user) }

  before do
    sign_in user
  end

  scenario "User can view a listing" do
    visit user_dashboard_path
    click_link "View Listings"
    expect(page).to have_content(listing.title)
  end 

  scenario "user can view a specific listing" do
    visit user_dashboard_path
    click_link "View Listings"
    click_link listing.title
    expect(page).to have_content(listing.title)
    expect(page).to have_content(listing.description)
    expect(page).to have_content(listing.price)
  end

  scenario "User can update a listing" do 
    visit user_dashboard_path
    click_link "View Listings"
    click_link listing.title
    click_link "Edit Listing"

    fill_in "Title", with: "Updated Test Listing"
    fill_in "Description", with: "This is a updated test listing"
    fill_in "Price", with: "150"
    click_button "Next Step"

    select "Kitchen", from: "product_listing_category_ids"
    click_button "Next Step"

    # Make sure test image exists before attaching
    test_image_path = Rails.root.join("spec/fixtures/files/test_image.jpg")
    raise "Test image not found at #{test_image_path}" unless File.exist?(test_image_path)

    attach_file "product_listing_images", test_image_path
    
    click_button "Finish"

    expect(page).to have_content("Updated Test Listing")
    expect(page).to have_content("This is a updated test listing")
    expect(page).to have_content("150")
    expect(page).to have_content("Kitchen")
    
    click_button "Publish Listing"
    expect(current_path).to eq(user_dashboard_path)
  end 


  scenario "User can delete a listing" do 
    visit user_dashboard_path
    click_link "View Listings"
    click_link listing.title
    click_button "Delete Listing"
    expect(page).to have_content("Listing has been deleted")
  end 

end