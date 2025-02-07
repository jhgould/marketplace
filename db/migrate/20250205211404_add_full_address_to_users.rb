class AddFullAddressToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :full_address, :string
  end
end
