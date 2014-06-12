class UserController < ApplicationController
  def new
    @greeting_message = t :new_user_signup
  end

  def sign_up
    @greeting_message = t :new_hacker_signup
    render action: :new
  end
end
