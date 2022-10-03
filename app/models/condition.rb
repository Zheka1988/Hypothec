class Condition < ApplicationRecord
  belongs_to :mortgage

  validates :interest_rate, :value_max_loan_amount, presence: true
  validate :validate_value_interest_rate

  private

  def validate_value_interest_rate
    count = 0
    Condition.attribute_names.each do |name_attribute|
      if name_attribute.include?('value_interest_rate') && send(name_attribute) != nil
        count += 1
        break
      end
    end

    if count == 0
      errors.add(:interest_rate, I18n.t('flash.conditions.value_interest_rate'))
    end
  end
end
