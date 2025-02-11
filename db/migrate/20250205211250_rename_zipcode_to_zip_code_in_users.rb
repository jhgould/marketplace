class RenameZipcodeToZipCodeInUsers < ActiveRecord::Migration[7.1]
  def change
    rename_column :users, :zipcode, :zip_code
  end
end
