class AddOnboardingFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :phone_number, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :street_address, :string
    add_column :users, :unit_number, :string
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :zipcode, :string
    add_column :users, :country, :string
  end
end
