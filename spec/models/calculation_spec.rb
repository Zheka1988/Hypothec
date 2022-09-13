require 'rails_helper'

RSpec.describe Calculation, type: :model do
  it { should validate_presence_of :apartment_price }
  it { should validate_presence_of :accumulation }
  it { should validate_presence_of :rental_cost }
  it { should validate_presence_of :monthly_savings }
  it { should validate_presence_of :mortgage_ids }
end
