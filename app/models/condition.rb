class Condition < ApplicationRecord
  belongs_to :mortgage

  validates :interest_rate, :max_loan_amount, presence: true
end
