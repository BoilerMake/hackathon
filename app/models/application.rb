class Application < ActiveRecord::Base
  validates_presence_of :gender
  validates_presence_of :essay
  validates_presence_of :gender
  validates_presence_of :expected_graduation
  validates_presence_of :github
  validates_presence_of :tshirt_size
  validates_presence_of :cell_phone
  validates_presence_of :linkedin
  validates_presence_of :dietary_restrictions
  validates_presence_of :previous_experience
  validates_presence_of :essay

  belongs_to :hacker

end
