require 'rails_helper'
require "cancan/matchers"

RSpec.describe Ability do
  subject(:ability) { Ability.new(user) }
  
  describe 'for guest' do
    let(:user) { nil }
    it { should be_able_to :read, Mortgage, Condition }
    it { should be_able_to :create, Calculation }
    it { should be_able_to :show, Calculation }
  end

  describe 'for user' do
    let(:user) { create :user }
    it { should be_able_to :read, Mortgage, Condition }
    it { should be_able_to :create, Calculation } 
    it { should be_able_to :read, Calculation, author_id: user.id }  
  end

  describe 'for admin' do
    let(:user) { create :user, :admin }
    it { should be_able_to :manage, Calculation, Mortgage, Condition }
  end

end