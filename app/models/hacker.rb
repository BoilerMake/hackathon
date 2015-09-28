class Hacker < User
  belongs_to :school
  belongs_to :team
  has_one :application
  has_many :hacker_ranking

  validate :team_size_is_okay

  accepts_nested_attributes_for :application

  def self.textees
    Hacker.joins(:application)
          .where(applications: {can_text: true })
          .where.not(applications: {cell_phone: nil})
  end

  def self.started_applicants
    Hacker.joins(:application)
  end

  def self.application_completed
    Hacker.started_applicants.where.not(
      school_id: nil,
      first_name: nil,
      last_name: nil,
      "applications.resume" => nil,
      "applications.tshirt_size" => nil,
      "applications.essay1" => nil,
      "applications.essay2" => nil
    ).where.not(
      school_id: -1,
      first_name: "",
      last_name: "",
      "applications.resume" => "",
      "applications.tshirt_size" => "",
      "applications.essay1" => "",
      "applications.essay2" => ""
    )
  end

  def self.application_incomplete
    Hacker.started_applicants.where(
      "school_id = ? OR
      first_name = ? OR
      last_name = ? OR
      applications.resume = ? OR
      applications.tshirt_size = ? OR
      applications.essay1 = ? OR
      applications.essay2 = ? OR
      school_id = ? OR
      first_name = ? OR
      last_name = ? OR
      applications.resume = ? OR
      applications.tshirt_size = ? OR
      applications.essay1 = ? OR
      applications.essay2 = ?",
      nil, nil, nil, nil, nil, nil, nil, -1, "", "", "", "", "", ""
    )
  end


  def accepted?
    status == 'Accepted'
  end

  def confirmed?
    status == 'Accepted' && confirmed
  end

  def standby?
    status == 'Standby'
  end

  def rejected?
    status == 'Rejected'
  end

  def declined?
    declined
  end

  def application_started?
    !application.nil?
  end

  def extra_fields_completed?
    transportation_method.present?
  end

  def application_completed?
    false if application.nil?
    attributes = [ first_name, last_name ].map do |el|
      el.present?
    end
    attributes << (school_id.present? && school_id != -1)
    if application.present?
      application_attrs = [ application.resume,
                            application.tshirt_size,
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
