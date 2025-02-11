class AdminPendingApartmentVerification < ApplicationRecord
  enum status: { pending: 'pending', approved: 'approved', denied: 'denied' }
  validates :submitted_street_address, :submitted_city, :submitted_state, :submitted_zip_code, :submitted_country, presence: true

  def self.submit_for_review(address, submitted_address)
    create!(
      street_address: address[:street_address],
      city:           address[:city],
      state:          address[:state],
      zip_code:       address[:zip_code],
      country:        address[:country],
      submitted_street_address: submitted_address["street_address"],
      submitted_city:           submitted_address["city"],
      submitted_state:          submitted_address["state"],
      submitted_zip_code:       submitted_address["zip_code"],
      submitted_country:        submitted_address["country"],
      status:         'pending'
    )
  end

  def self.ransackable_attributes(auth_object = nil)
    ["city", "country", "created_at", "id", "id_value", "state", "status", "street_address", "updated_at", "zip_code", "submitted_street_address", "submitted_city", "submitted_state", "submitted_zip_code", "submitted_country"]
  end
end
