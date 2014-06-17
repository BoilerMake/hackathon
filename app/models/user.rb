class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation

  has_secure_password validations: false
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :email
  before_create { generate_token(:auth_token) }

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
end
