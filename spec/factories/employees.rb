FactoryBot.define do
  factory :employee do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    company

    trait :with_manager do
      association :manager, factory: :employee
    end
  end
end
