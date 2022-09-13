FactoryBot.define do
  factory :condition do
    interest_rate { 'MyString_Interest_Rate' }
    value_interest_rate_with_commision { 2.5 }
    max_loan_amount { 'MyString' }
    value_max_loan_amount { 25 }
    max_loan_term { 'MyString' }
    max_age { 'MyString' }
    income { 'MyText' }
    note { 'MyText' }
    an_initial_fee { 'MyString' }
    experience_and_registration { 'MyText' }
    type_of_housing { 'MyString' }
    mortgage { nil }

    trait :invalid do
      interest_rate { nil }
      max_loan_amount { nil }
    end

    trait :value_interest_rate_invalid do
      value_interest_rate_with_commision { nil }
    end

    trait :partial do
      interest_rate { 'MyString_Interest_Rate' }
      max_loan_amount { 'MyString' }
      max_loan_term { 'MyString' }
      max_age { 'MyString' }
      income { nil }
      note { nil }
      an_initial_fee { nil }
      experience_and_registration { nil }
      type_of_housing { nil }      
    end
  end
end
