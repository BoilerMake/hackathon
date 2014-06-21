class Team < ActiveRecord::Base
  has_many :hackers
  before_create { generate_secret_key }

  def generate_secret_key
    self.secret_key = SecureRandom.urlsafe_base64
  end
end
