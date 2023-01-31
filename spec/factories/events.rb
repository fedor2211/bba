FactoryBot.define do
  factory :event do
    association :user

    title { "some_title" }
    description { "cool_description" }
    datetime { Time.now }
    address { "cool_place" }
  end
end
