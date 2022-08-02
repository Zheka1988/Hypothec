FactoryBot.define do
  factory :condition do
    interest_rate { "MyString" }
    max_loan_amount { "MyString" }
    max_loan_term { "MyString" }
    max_age { "MyString" }
    income { "MyText" }
    note { "MyText" }
    an_initial_fee { "MyString" }
    experience_and_registration { "MyText" }
    type_of_housing { "MyString" }
    mortgage { nil }
  end
end
