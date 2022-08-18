# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    
    can :read, [Mortgage, Condition], published: true

    return unless user.present?
    can :read, [Mortgage, Condition]

    return unless user.admin?
    can :manage, [Mortgage, Condition]
  end
end
