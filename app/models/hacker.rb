class Hacker < User
  belongs_to :school
  belongs_to :team
  has_one :application

  validates_format_of :email, with: /\A.*?\.edu\z/i
  validate :team_size_is_okay

  accepts_nested_attributes_for :application

  def accepted?
    false
  end

  def full_name
    fname = first_name.present? ? first_name : ''
    lname = last_name.present? ? last_name : ''
    "#{fname} #{lname}"
  end

  def best_name
    full_name.present? ? full_name : email
  end

  # this validation should never trigger, but its here as a failsafe
  # handled in TeamsController#join
  def team_size_is_okay
    if team.present?
      if team.hackers.count > 4
        errors.add(:team, 'Team is already full')
        return false
      end
    end
    true
  end

end
