class Hacker < User
  belongs_to :school
  belongs_to :team
  has_one :application

  validate :team_size_is_okay

  accepts_nested_attributes_for :application

  def accepted?
    status == 'Accepted'
  end

  def application_completed?
    false if application.nil?
    attributes = [ first_name, last_name ].map do |el|
      el.present?
    end
    if application.present?
      application_attrs = [ application.github,
                            application.resume,
                            application.cell_phone,
                            application.expected_graduation,
                            application.tshirt_size ]
      application_attrs.map! do |el|
        attributes << el.present?
      end
    end
    attributes.reduce(:&)
  end

  def eligible_for_sticker?
    false if application.nil?
    attributes = [ first_name, last_name ].map do |el|
      el.present?
    end
    if application.present?
      application_attrs = [ application.address_line_one,
                            application.city,
                            application.zip_code ]
      application_attrs.map! do |el|
        attributes << el.present?
      end
    end
    attributes.reduce(:&)
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
