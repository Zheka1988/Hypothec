# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    
    can :read, Mortgage, published: true

    return unless user.present?
    can :read, Mortgage

    return unless user.admin?
    can :manage, Mortgage
  end
end
