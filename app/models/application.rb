class Application < ActiveRecord::Base
  # I don't think we need to do this. We can accept incomplete applications, right?
  # This has the benefit of letting people complete their applications over time.
  # -Spencer
  # validates_presence_of :gender
  # validates_presence_of :essay
  # validates_presence_of :gender
  # validates_presence_of :github
  # validates_presence_of :previous_experience
  # validates_presence_of :essay

  belongs_to :hacker, foreign_key: 'hacker_id'

end
