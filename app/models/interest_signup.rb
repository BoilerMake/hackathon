class InterestSignup < ActiveRecord::Base
  validates :email, format: { with: /\S+@\S+\.\S+/, on: :create}
end
