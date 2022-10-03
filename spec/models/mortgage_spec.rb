require 'rails_helper'

RSpec.describe Mortgage, type: :model do
  it { should have_one(:condition).dependent(:destroy) }

  it { should validate_presence_of :title }
  it { should validate_presence_of :description }
  it { should validate_presence_of :type_mortgage }

  context 'validate_title_banks_partners' do
    let(:mortgage_commercial_bank) { build(:mortgage, :invalid_commercial_bank) }
    let(:mortgage_state_program) { build(:mortgage, :invalid_state_programm) }
    let(:mortgage_otbasy_bank) { build(:mortgage, :invalid_otbasy_bank) }

    it 'commercial_bank' do
      expect(mortgage_commercial_bank).to be_invalid
      expect(mortgage_commercial_bank.errors.full_messages.first).to include I18n.t('flash.mortgages.commercial_bank')
    end

    it 'state_programm' do
      expect(mortgage_state_program).to be_invalid
      expect(mortgage_state_program.errors.full_messages.first).to include I18n.t('flash.mortgages.state_programm')
    end

    it 'otbasy_bank' do
      expect(mortgage_otbasy_bank).to be_invalid
      expect(mortgage_otbasy_bank.errors.full_messages.first).to include I18n.t('flash.mortgages.otbasy_bank')
    end
  end
end
