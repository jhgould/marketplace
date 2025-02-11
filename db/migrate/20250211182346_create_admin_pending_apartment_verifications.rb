class CreateAdminPendingApartmentVerifications < ActiveRecord::Migration[7.1]
  def change
    create_table :admin_pending_apartment_verifications do |t|
      t.string :street_address
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :country
      t.string :status

      t.timestamps
    end
  end
end
