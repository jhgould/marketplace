ActiveAdmin.register User do
  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    actions
  end

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :onboarding_complete, :phone_number, :first_name, :last_name, :street_address, :unit_number, :city, :state, :zip_code, :country, :full_address, :apartment_id, :zipcode
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :onboarding_complete, :phone_number, :first_name, :last_name, :street_address, :unit_number, :city, :state, :zip_code, :country, :full_address, :apartment_id, :zipcode]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
