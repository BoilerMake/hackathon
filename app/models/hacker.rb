class Hacker < User
  validates_presence_of :school_id
  validates_presence_of :team_id
  validates_presence_of :github

  belongs_to :school

  def accepted?
    false
  end

end
