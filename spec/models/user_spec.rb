require 'rails_helper'

RSpec.describe User, :type => :model do

  describe User do
    it "has a password digest on save" do
      user_params = { first_name: 'test', last_name: 'name', school_id: 45,
                      team_id: 47, email: 't@test.com', github: 'cell',
                      password: 'ttest', password_confirmation: 'ttest' }
      User.new(user_params).save
      User.last.password_digest.should_not be_nil
    end
  end
end
