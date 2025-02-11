class OnboardingController < ApplicationController
  include Wicked::Wizard
  
  before_action :authenticate_user!
  before_action :set_user

  # Define the steps in order
  steps(*User.form_steps)

  def show
    case step 
    when "apartment" 
      @apartment = apartment_search   
    end 
    render_wizard
  end

  def update
    @user.form_step = step.to_s 
    case step 
    when "personal_info"
      address_params = normalize_address(user_params(step))
      update_user(address_params)
    else 
      update_user(user_params(step))
    end 
  end

  def join_apartment
    if @user.update(apartment_id: params[:apartment_id])
      @user.update(onboarding_complete: true)
      finish_wizard_path
    else 
      render_wizard
    end 
  end 

  private

  def normalize_address(user_params)
    normalized_address = NormalizationService.new.normalize(user_params)
    normalized_address["unit_number"] = user_params["unit_number"]
    address_params = user_params.merge(normalized_address)
  end 

  def update_user(user_params) 
    if @user.update(user_params)
      render_wizard @user
    else
      render_wizard
    end
  end 

  def apartment_search
    address = {
      street_address: @user.street_address,
      city:           @user.city,
      state:          @user.state,
      zip_code:       @user.zip_code,
      country:        @user.country
    }
    apartment = ApartmentSearchService.new.search(address)
    unless apartment
      # AdminApartmentSearchRequest.new.potential_apartment(address)
    end
    apartment
  end 

  def set_user
    @user = current_user
  end

  def user_params(step)
    permitted = case step
                when "sign_up"
                  [:email, :password, :password_confirmation]
                when "personal_info"
                  [:first_name, :last_name, :street_address, :unit_number, :city, :state, :zip_code, :country]
                when "phone"
                  [:phone_number]
                when "overview" 
                  []
                when "apartment"
                  [:apartment_id] 
                end
    params.require(:user).permit(permitted).merge(form_step: step)
  end

  def finish_wizard_path
    puts "hello world"
    # Where to redirect after finishing the wizard (adjust as needed)
    # user_dashboard_path
  end
end
