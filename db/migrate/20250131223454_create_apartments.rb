class CreateApartments < ActiveRecord::Migration[7.1]
  def change
    create_table :apartments do |t|
      t.string :street_address, null: false
      t.string :city, null: false
      t.string :state, null: false
      t.string :zip_code, null: false
      t.string :country, null: false
      t.string :full_address

      t.timestamps
    end
  end
end
