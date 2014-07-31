class School < ActiveRecord::Base
  has_many :users

  def self.hackers
    where(type: 'Hacker')
  end
end
