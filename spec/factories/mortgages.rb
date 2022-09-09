FactoryBot.define do
  factory :mortgage do
    title { 'MyString' }
    description { 'MyText' }
    type_mortgage { :commercial_bank }
    title_banks_partners { [] }

    trait :invalid do
      title { nil }
    end

    trait :invalid_commercial_bank do
      type_mortgage { :commercial_bank }
      title_banks_partners { ['HalykBank', 'KaspiBank'] }
    end
    trait :commercial_bank do
      type_mortgage { :commercial_bank }
    end

    trait :invalid_state_programm do
      type_mortgage { :state_programm }
    end
    trait :state_programm do
      type_mortgage { :state_programm }
      title_banks_partners { ['HalykBank', 'KaspiBank'] }
    end

    trait :invalid_otbasy_bank do
      type_mortgage { :otbasy_bank }
      title_banks_partners { ['HalykBank', 'KaspiBank'] }
    end
    trait :otbasy_bank do
      type_mortgage { :otbasy_bank }
    end
  end
end
