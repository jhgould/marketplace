require 'rails_helper'

RSpec.feature "User sign up flow", type: :feature do

    scenario "New user signs up with a valid address" do
            apartment = create(:apartment, :real_address)
            visit new_user_registration_path

            fill_in "Email", with: "user@test.com"
            fill_in "Password", with: "password"
            fill_in "Password confirmation", with: "password"
            click_button "Sign up"

            fill_in "First name", with: "test"
            fill_in "Last name", with: "user"
            fill_in "Street address", with: "3463 Walnut Street"
            fill_in "Unit number", with: " 1363"
            fill_in "City", with: "Denver"
            fill_in "State", with: "CO"
            fill_in "Zipcode", with: "80205"
            fill_in "Country", with: "USA"

            click_button "Next"

            expect(page).to have_content("Phone Number")
            fill_in "Phone number", with: "(123)123-1234"

            click_button "Next"

            expect(page).to have_content("test")
            expect(page).to have_content("user")

            click_button "Confirm"

            expect(page).to have_content("3463 Walnut Street")
            # expect(page).to have_content("Confirm your apartment address and join!")
            click_button "Join"

            # expect(current_path).to eq(user_dashboard_path)
        end
end
    