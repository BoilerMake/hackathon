class Ability
  include CanCan::Ability

  def initialize(user)
    can :create, Hacker
    if user.present?
      if user.exec?
        can :manage, :all
      elsif user.hacker?
        can :manage, [Application]
        can [ :dashboard, :new, :create, :update, :confirm, :decline ], Hacker
        can [ :index ], School
      end
    end
    can :index, Update
  end
end
