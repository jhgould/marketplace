require 'rails_helper'


RSpec.feature "Sign in and sign out", type: :feature do
    scenario "User signs in and signs out" do
        apartment = create(:apartment, :real_address)
        user = User.create!(email: "test@example.com", password: "password", apartment_id: apartment.id)
        
        user.update(onboarding_complete: true)

        visit new_user_session_path

        fill_in "Email", with: user.email
        fill_in "Password", with: user.password
        click_button "Log in"

        expect(page).to have_content("Signed in successfully")

        click_button "Logout"

        expect(page).to have_content("Signed out successfully")
    end
end
    