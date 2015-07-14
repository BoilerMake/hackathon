class Hacker < User
  belongs_to :school
  belongs_to :team
  has_one :application

  validate :team_size_is_okay

  accepts_nested_attributes_for :application

  def self.textees
    Hacker.joins(:application)
          .where(applications: {can_text: true })
          .where.not(applications: {cell_phone: nil})
  end

  def accepted?
    status == 'Accepted'
  end

  def standby?
    status == 'Standby'
  end

  def rejected?
    status == 'Rejected'
  end

  def declined?
    status == 'Declined'
  end

  def application_completed?
    false if application.nil?
    attributes = [ first_name, last_name, school_id ].map do |el|
      el.present?
    end
    if application.present?
      application_attrs = [ application.resume,
                            application.tshirt_size,
                            application.cell_phone,
                            application.essay1,
                            application.essay2 ]
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
