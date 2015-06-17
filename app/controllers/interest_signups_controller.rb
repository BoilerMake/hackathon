class InterestSignupsController < ApplicationController
  skip_before_action :require_login
  respond_to :js, :json

  def create
    email_address = params['interest_signup']['email'].downcase

    @interest_signup = InterestSignup.create(email: email_address)

    if @interest_signup.valid?
      @interest_signup.mailchimp_subscribe
    end

    respond_with @interest_signup
  end
end
