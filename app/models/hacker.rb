class Hacker < User
  belongs_to :school
  belongs_to :team
  has_one :application

  def accepted?
    false
  end

end
