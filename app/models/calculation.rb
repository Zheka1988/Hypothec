class Calculation < ApplicationRecord
  validates :apartment_price,
            :accumulation,
            :rental_cost,
            :monthly_savings,
            :mortgage_ids, presence: true
end
