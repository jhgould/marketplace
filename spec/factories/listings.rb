FactoryBot.define do
  factory :listing do
    association :apartment
    association :user
    title { "Test Listing" }
    description { "This is a test description" }
    price { 9.99 }
    currency { "Dollar" }
    type { "ProductListing" } # Ensure proper STI
    metadata { {} }
    status { "Pending" }

    # Directly add a category and image at creation
    categories { [Category.find_or_create_by!(name: "Test Category")] }

    after(:build) do |listing|
      listing.images.attach(
        io: File.open(Rails.root.join("spec/fixtures/files/test_image.jpg")),
        filename: "test_image.jpg",
        content_type: "image/jpeg"
      )
    end
  end

  trait :product_listing do
    type { "ProductListing" }
  end
end
