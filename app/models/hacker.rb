class Hacker < User
  attr_accessor :email, :school
  belongs_to :school
  belongs_to :team
  has_one :application

  validates_format_of :email, with: /\A.*?\.edu\z/i

  accepts_nested_attributes_for :application

  def accepted?
    false
  end

  def full_name
    fname = first_name.present? ? first_name : ''
    lname = last_name.present? ? last_name : ''
    "#{fname} #{lname}"
  end

end
