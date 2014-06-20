class Hacker < User
  belongs_to :school
  belongs_to :team
  has_one :application

  validates_format_of :email, with: /\A.*?\.edu\z/i

  accepts_nested_attributes_for :application

  def accepted?
    false
  end

end
