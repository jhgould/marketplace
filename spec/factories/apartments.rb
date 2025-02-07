FactoryBot.define do
  factory :apartment do
    street_address { "MyString" }
    city { "MyString" }
    state { "MyString" }
    zip_code { "MyString" }
    country { "MyString" }
    full_address { "MyString" }

    trait :real_address do
      street_address { "3463 Walnut Street" }
      city { "Denver" }
      state { "Colorado" }
      zip_code { "80205" }
      country { "United States" }
      full_address { "Edit at River North, 3463, Walnut Street, Five Points, Denver, Colorado, 80205, United States" }
    end
  end
end
