class Condition < ApplicationRecord
  belongs_to :mortgage

  validates :interest_rate, :value_max_loan_amount, presence: true
  validate :validate_value_interest_rate

  private

  def validate_value_interest_rate
    count = 0
    name_attributes = [] 
    Condition.attribute_names.each do |name_attribute|
      if name_attribute.include?('value_interest_rate') && send(name_attribute) != nil
        count += 1
      end
    end

    if count == 0
      errors.add(:interest_rate, "at least one value must be specified")
    end
  end
end
