FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "foo_user#{n}" }
    sequence(:email) { |n| "foo_mail#{n}@example.com" }
    password { "123456" }
  end
end
