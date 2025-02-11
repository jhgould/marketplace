class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  encrypts :phone_number, :street_address, :unit_number, :city, :state, :zipcode, :country, deterministic: true
  
  
  cattr_accessor :form_steps do 
    %w[personal_info phone overview apartment]
  end
  attr_accessor :form_step

  # Returns true if the current step is equal to or comes after the given step.
  def required_for_step?(step)
    return true if form_step.nil?  # Validate all if no step is set
    form_steps.index(step.to_s) <= form_steps.index(form_step.to_s)
  end

  # --- Conditional Validations ---

  # Signup step validations
  # with_options if: -> { required_for_step?(:signup) } do
  #   validates :email, presence: true
  #   validates :password, presence: true
  # end

  # # Personal Information step validations
  # with_options if: -> { required_for_step?(:personal_info) } do
  #   validates :first_name, presence: true
  #   validates :last_name, presence: true
  #   validates :street_address, presence: true
  #   validates :city, presence: true
  #   validates :state, presence: true
  #   validates :zipcode, presence: true
  #   validates :country, presence: true
  # end

  # # Phone step validations
  # with_options if: -> { required_for_step?(:phone) } do
  #   validates :phone_number, presence: true
  # end

    # Additional validations for other steps can be added here as needed.



  def self.ransackable_attributes(auth_object = nil)
    ["apartment_id", "city", "country", "created_at", "email", "encrypted_password", "first_name", "full_address", "id", "id_value", "last_name", "onboarding_complete", "phone_number", "remember_created_at", "reset_password_sent_at", "reset_password_token", "state", "street_address", "unit_number", "updated_at", "zip_code"]
  end

end
