class AddSubmittedAddressToAdminPendingApartmentVerifications < ActiveRecord::Migration[7.1]
  def change
    add_column :admin_pending_apartment_verifications, :submitted_street_address, :string
    add_column :admin_pending_apartment_verifications, :submitted_city, :string
    add_column :admin_pending_apartment_verifications, :submitted_state, :string
    add_column :admin_pending_apartment_verifications, :submitted_zip_code, :string
    add_column :admin_pending_apartment_verifications, :submitted_country, :string
  end
end
