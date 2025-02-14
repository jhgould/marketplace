FactoryBot.define do
  factory :listing do
    apartment { nil }
    user { nil }
    title { "MyString" }
    description { "MyText" }
    price { "9.99" }
    currency { "MyString" }
    type { "" }
    metadata { "" }
    status { "MyString" }
  end
end
