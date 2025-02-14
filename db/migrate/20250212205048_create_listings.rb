class CreateListings < ActiveRecord::Migration[7.1]
  def change
    create_table :listings do |t|
      t.references :apartment, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.decimal :price, precision: 10, scale: 2
      t.string :currency
      t.string :type
      t.jsonb :metadata
      t.string :status

      t.timestamps
    end
  end
end
