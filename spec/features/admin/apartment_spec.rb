require 'rails_helper'


RSpec.describe 'Admin::Apartments', type: :feature do
    let(:admin) { FactoryBot.create(:admin_user) }

    before do
        login_as(admin, scope: :admin_user)
    end

    scenario "admin creates valid apartment" do 
        sign_in admin
        visit new_admin_apartment_path
        fill_in 'Street address', with: '3463 Walnut st'
        fill_in 'City', with: 'Denver'
        fill_in 'State', with: 'CO'
        fill_in 'Zip code', with: '80205'
        fill_in 'Country', with: 'USA'
        click_button 'Create Apartment'
        expect(page).to have_content 'Apartment was successfully created.'
    end 
end 