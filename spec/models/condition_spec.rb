require 'rails_helper'

RSpec.describe Condition, type: :model do
  it { should belong_to :mortgage }

  it { should validate_presence_of :interest_rate }
  it { should validate_presence_of :value_max_loan_amount }

  context 'value_interest_rate' do
    let(:mortgage) { create :mortgage }
    let(:condition) { build :condition, :value_interest_rate_invalid, mortgage: mortgage }
    
    it 'validate_value_interest_rate' do
      expect(condition).to be_invalid
      expect(condition.errors.full_messages.first).to include('at least one value must be specified')
    end
  end
end
