# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    
    can :read, [Mortgage, Condition]
    can :create, Calculation
    can :show, Calculation

    return unless user.present?
    can :read, [Mortgage, Condition]
    can :create, Calculation
    can :read, Calculation, author_id: user.id

    return unless user.admin?
    can :manage, [Mortgage, Condition, Calculation]
  end
end
