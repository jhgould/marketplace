FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "password123" }
    first_name { "John" }
    last_name { "Doe" }
    phone_number { "555-123-4567" }
    street_address { "3463 Walnut Street" }
    unit_number { "4B" }
    city { "Denver" }
    state { "Colorado" }
    zip_code { "80205" }
    country { "United States" }
    full_address { "Edit at River North, 3463, Walnut Street, Five Points, Denver, Colorado, 80205, United States" }
    onboarding_complete { true }
  end
end
