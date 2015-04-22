class InterestSignupsController < ApplicationController
  skip_before_action :require_login

  def create
    email_address = params['interest_signup']['email']

    @interest_signup = InterestSignup.create(email: email_address)
    if !@interest_signup
      render json: { error: 'invalid'}
    end

    # MAILCHIMP-API-KEY
    mailchimp_api = '1e94385b50dd6dd1a2606ff31f6e5982-us4'
    # MAILCHIMP-LIST-ID
    mailchimp_list = '64bd0c0cf2'

    mailchimp = Mailchimp::API.new(mailchimp_api)
    mailchimp.lists.subscribe(mailchimp_list, { email: @interest_signup.email})

    respond_to do |format|
      format.json { render json: @interest_signup }
    end
  end
end
