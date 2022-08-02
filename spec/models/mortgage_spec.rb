require 'rails_helper'

RSpec.describe Mortgage, type: :model do
  it { should have_one(:condition).dependent(:destroy) }

  it { should validate_presence_of :title }
  it { should validate_presence_of :description }
end
