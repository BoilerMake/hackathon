class Ability
  include CanCan::Ability

  def initialize(user)
    can :create, Hacker
    if user.present?
      if user.exec?
        can :manage, :all
      elsif user.sponsor?
        can [:resume_portal, :hackers], Sponsor
      elsif user.hacker?
        can :manage, [Application]
        can [ :dashboard, :new, :create, :update, :confirm, :decline, :passbook ], Hacker
        can [ :index ], School
      end
    end
    can :index, Update
  end
end
