require 'rails_helper'

RSpec.describe Calculation, type: :model do
  it { should validate_presence_of :apartment_price }
  it { should validate_presence_of :accumulation }
  it { should validate_presence_of :rental_cost }
  it { should validate_presence_of :monthly_savings }

  context 'make_calculation' do
    let(:mortgage) { create :mortgage }
    let!(:condition) { create :condition, mortgage: mortgage }
    let!(:calculation) { create :calculation }

    it 'verification of calculated data' do
      calculation.make_calculation(nil)
      expect(calculation[:calculated_values][mortgage.id.to_s][:monthly_payment][:value_interest_rate_with_commision][20].first).to eq 332660
      expect(calculation[:calculated_values][mortgage.id.to_s][:overpayment][:value_interest_rate_with_commision][20].first).to eq 3159600 
      expect(calculation[:calculated_values][mortgage.id.to_s][:sum_rental_costs][:value_interest_rate_with_commision].first).to eq 3520000    
    end
  end
end
