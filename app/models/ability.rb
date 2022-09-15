# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    
    can :read, [Mortgage, Condition]
    can :manage, Calculation

    return unless user.present?
    can :read, [Mortgage, Condition]
    can :manage, Calculation

    return unless user.admin?
    can :manage, [Mortgage, Condition, Calculation]
  end
end
