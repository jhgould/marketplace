class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  encrypts :phone_number, :street_address, :unit_number, :city, :state, :zipcode, :country, :full_address, deterministic: true

  belongs_to :apartment, optional: true
  has_many :listings, dependent: :destroy

  cattr_accessor :form_steps do 
    %w[personal_info phone overview apartment]
  end
  
  attr_accessor :form_step

  def required_for_step?(step)
    return true if form_step.nil?  # Validate all if no step is set
    form_steps.index(step.to_s) <= form_steps.index(form_step.to_s)
  end


  def self.ransackable_associations(auth_object = nil)
    ["apartment"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["apartment_id", "city", "country", "created_at", "email", "encrypted_password", "first_name", "full_address", "id", "id_value", "last_name", "onboarding_complete", "phone_number", "remember_created_at", "reset_password_sent_at", "reset_password_token", "state", "street_address", "unit_number", "updated_at", "zip_code"]
  end

end
