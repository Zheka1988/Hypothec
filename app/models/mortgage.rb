class Mortgage < ApplicationRecord
  enum :type_mortgage, [:commercial_bank, :state_programm, :otbasy_bank]
  has_one :condition, dependent: :destroy
  
  validates :title, :description, :type_mortgage, presence: true
  validate :validate_title_banks_partners

  private
  def validate_title_banks_partners
    if type_mortgage == 'commercial_bank' && !title_banks_partners.empty?
      errors.add(:title_banks_partners, "should be empty")
    end

    if type_mortgage == 'state_programm' && title_banks_partners.empty? 
      errors.add(:title_banks_partners, "can't be empty")
    end

    if type_mortgage == 'otbasy_bank' && !title_banks_partners.empty?
      errors.add(:title_banks_partners, "should be empty")
    end        
  end

end
