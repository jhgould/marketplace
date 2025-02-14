class ListingCategory < ApplicationRecord
  belongs_to :listing
  belongs_to :category

  def self.ransackable_attributes(auth_object = nil)
    ["category_id", "created_at", "id", "id_value", "listing_id", "updated_at"]
  end
end
