class Hacker < User
  belongs_to :school
  belongs_to :team
  has_one :application

  validates_format_of :email, with: /\A.*?\.edu\z/i

  def accepted?
    false
  end

end
