class Hacker < User
  belongs_to :school
  belongs_to :team
  has_one :application

  accepts_nested_attributes_for :application

  def accepted?
    false
  end

end
