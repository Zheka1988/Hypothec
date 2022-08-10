FactoryBot.define do
  factory :mortgage do
    title { 'MyString' }
    description { 'MyText' }

    trait :invalid do
      title { nil }
    end
  end
end
