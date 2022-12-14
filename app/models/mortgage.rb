class Mortgage < ApplicationRecord
  enum :type_mortgage, [:commercial_bank, :state_programm, :otbasy_bank]
  has_one :condition, dependent: :destroy
  
  validates :title, :description, :type_mortgage, presence: true
  validate :validate_title_banks_partners

  private
  def validate_title_banks_partners
    if type_mortgage == 'commercial_bank' && (title_banks_partners.empty? || title_banks_partners.length > 1)
      errors.add(:title_banks_partners, I18n.t('flash.mortgages.commercial_bank') )
    elsif type_mortgage == 'state_programm' && title_banks_partners.empty? 
      errors.add(:title_banks_partners, I18n.t('flash.mortgages.state_programm') )
    elsif type_mortgage == 'otbasy_bank' && ( title_banks_partners.empty? || ( title_banks_partners.length > 1 || title_banks_partners.first != 'OtbasyBank' ))
      errors.add(:title_banks_partners, I18n.t('flash.mortgages.otbasy_bank') )
    end      
  end
end
