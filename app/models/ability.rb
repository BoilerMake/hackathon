class Ability
  include CanCan::Ability

  def initialize(user)
    can :create, Hacker
    if user.present?
      if user.exec?
        can :manage, :all
      elsif user.hacker?
        can :manage, [Application, Team]
        can :index, Update
        can [ :dashboard, :new, :create, :update ], Hacker
      end
    else
      can :index, Update
    end
  end
end
