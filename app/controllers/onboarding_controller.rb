class OnboardingController < ApplicationController
  include Wicked::Wizard
  
  before_action :authenticate_user!
  before_action :set_user

  # Define the steps in order
  steps(*User.form_steps)

  def show
    if step == "apartment"
      @apartment = apartment_search
      if @apartment.nil?
        flash[:alert] = "Apartment not found. We have submitted your address for verification."
        redirect_to root_path and return
      end
    end
    render_wizard
  end

  def update
    @user.form_step = step.to_s
    user_params_step = user_params(step)

    if step == "personal_info"
      submitted_address(user_params_step)
      address_params = normalize_address(user_params_step)
      update_user(address_params)
    else
      update_user(user_params_step)
    end
  end

  def join_apartment
    if @user.update(apartment_id: params[:apartment_id], onboarding_complete: true)
      redirect_to finish_wizard_path and return
    else
      render_wizard
    end
  end

  private

  def submitted_address(user_params)
    session[:submitted_address] = user_params.slice(
      "street_address", "city", "state", "zip_code", "country"
    )
  end

  def normalize_address(user_params)
    normalized_address = NormalizationService.new.normalize(user_params)
    normalized_address["unit_number"] = user_params["unit_number"]
    user_params.merge(normalized_address)
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
      AdminPendingApartmentVerification.submit_for_review(address, session[:submitted_address])
    end
    apartment
  end

  def set_user
    @user = current_user
  end

  def user_params(step)
    permitted_attributes = {
      "sign_up" => [:email, :password, :password_confirmation],
      "personal_info" => [:first_name, :last_name, :street_address, :unit_number, :city, :state, :zip_code, :country],
      "phone" => [:phone_number],
      "overview" => [],
      "apartment" => [:apartment_id]
    }

    permitted = permitted_attributes[step] || []
    params.require(:user).permit(permitted).merge(form_step: step)
  end

  def finish_wizard_path
    user_dashboard_path
  end
end
