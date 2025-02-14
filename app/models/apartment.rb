class Apartment < ApplicationRecord
  validates :street_address, :city, :state, :zip_code, :country, presence: true
  has_many :users

  def self.ransackable_attributes(auth_object = nil)
    ["city", "country", "created_at", "full_address", "id", "id_value", "state", "street_address", "updated_at", "zip_code"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["users"]
  end
end
