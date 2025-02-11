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
            fill_in "Zip code", with: "80205"
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

            expect(current_path).to eq(user_dashboard_path)
        end

        scenario "New user signs up with an invalid address" do
            apartment = create(:apartment, :real_address)
            visit new_user_registration_path

            fill_in "Email", with: "user@test.com"
            fill_in "Password", with: "password"
            fill_in "Password confirmation", with: "password"
            click_button "Sign up"

            fill_in "First name", with: "test"
            fill_in "Last name", with: "user"
            fill_in "Street address", with: "424 Lincoln Ave"
            fill_in "Unit number", with: " 1363"
            fill_in "City", with: "Steamboat Springs"
            fill_in "State", with: "CO"
            fill_in "Zip code", with: "80205"
            fill_in "Country", with: "USA"

            click_button "Next"

            expect(page).to have_content("Phone Number")
            fill_in "Phone number", with: "(123)123-1234"

            click_button "Next"

            expect(page).to have_content("test")
            expect(page).to have_content("user")

            click_button "Confirm"

            expect(current_path).to eq(root_path)
            expect(page).to have_content("Apartment not found. We have submitted your address for verification.")

        end

        scenario "Admin approves pending verification and user can access their account" do
            # Initial user signup with unverified address
            visit new_user_registration_path
            fill_in "Email", with: "pending@test.com"
            fill_in "Password", with: "password"
            fill_in "Password confirmation", with: "password"
            click_button "Sign up"
    
            fill_in "First name", with: "pending"
            fill_in "Last name", with: "user"
            fill_in "Street address", with: "424 Lincoln Ave"
            fill_in "Unit number", with: "1363"
            fill_in "City", with: "Steamboat Springs"
            fill_in "State", with: "CO"
            fill_in "Zip code", with: "80487"
            fill_in "Country", with: "USA"
            click_button "Next"
    
            fill_in "Phone number", with: "(123)123-1234"
            click_button "Next"
            click_button "Confirm"
    
            expect(page).to have_content("Apartment not found. We have submitted your address for verification.")
            click_button "Logout"

            # Create and approve the apartment through admin
            admin = create(:admin_user)
            apartment = create(:apartment, :steamboat)
    
            # User tries to log in after apartment is approved
            visit new_user_session_path
            fill_in "Email", with: "pending@test.com"
            fill_in "Password", with: "password"
            click_button "Log in"

            click_button "Next"

            expect(page).to have_content("Phone Number")
            fill_in "Phone number", with: "(123)123-1234"

            click_button "Next"

            expect(page).to have_content("test")
            expect(page).to have_content("user")

            click_button "Confirm"

            expect(page).to have_content("424 Lincoln Avenue")
            click_button "Join"
            
            expect(current_path).to eq(user_dashboard_path)
        end 

end
