class Application < ActiveRecord::Base
  validates_presence_of :gender
  validates_presence_of :essay
  validates_presence_of :gender
  validates_presence_of :github
  validates_presence_of :previous_experience
  validates_presence_of :essay

  belongs_to :hacker, foreign_key: 'hacker_id'

end
