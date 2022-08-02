require 'rails_helper'

RSpec.describe Condition, type: :model do
  it { should belong_to :mortgage }

  it { should validate_presence_of :interest_rate }
  it { should validate_presence_of :max_loan_amount }
end
