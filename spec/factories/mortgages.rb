FactoryBot.define do
  sequence :title do |n|
    "New_mortgage#{n}"
  end

  factory :mortgage do
    title
    description { 'MyText' }
    type_mortgage { :commercial_bank }
    title_banks_partners { ['HalykBank'] }

    trait :invalid do
      title { nil }
    end

    trait :invalid_commercial_bank do
      type_mortgage { :commercial_bank }
      title_banks_partners { [] }
    end
    trait :commercial_bank do
      type_mortgage { :commercial_bank }
      title_banks_partners { ['HalykBank'] }
    end

    trait :invalid_state_programm do
      type_mortgage { :state_programm }
      title_banks_partners { [] }
    end
    trait :state_programm do
      type_mortgage { :state_programm }
    end

    trait :invalid_otbasy_bank do
      type_mortgage { :otbasy_bank }
    end
    trait :otbasy_bank do
      type_mortgage { :otbasy_bank }
      title_banks_partners { ['OtbasyBank'] }
    end
  end
end
