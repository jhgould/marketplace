class AddApartmentIdToUsers < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :apartment, null: true, foreign_key: true
  end
end
