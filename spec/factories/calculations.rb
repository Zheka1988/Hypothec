FactoryBot.define do
  factory :calculation do
    apartment_price { 21000000 }
    accumulation { 1000000 }
    rental_cost { 110000 }
    monthly_savings { 100000 }
  
    trait :invalid do
      apartment_price { nil }
    end
  end
end
