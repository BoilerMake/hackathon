class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation

  has_secure_password validations: false
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :email
end
