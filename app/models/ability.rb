class Ability
  include CanCan::Ability

  def initialize(user)
    can :create, Hacker
    if user.present?
      if user.exec?
        can :manage, :all
      elsif user.hacker?
        can :manage, [Hacker, Application, Team]
      end
    end
  end
end
