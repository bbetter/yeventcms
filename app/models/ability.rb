# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.role == "admin"
      can :manage, :all
    elsif user.analytic?
      can :manage, [ EventParam, Event ]
      can :read, :all
      can :create, Comment
    elsif user.dev?
      can :manage, Release
      can :read, :all
      can :create, Comment
    else # user
      can :read, :all
    end
  end
end
