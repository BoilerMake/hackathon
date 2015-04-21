class InterestSignupController < ApplicationController
   skip_before_filter  :verify_authenticity_token
   #^^ temporary
skip_before_action :require_login
def new
  end

  def create
    email_inp = params["email"]
    #validate this

    InterestSignups.create(email: email_inp)
    render :text => email_inp
    # mailchimp = Mailchimp::API.new(MAILCHIMP-API-KEY)
    # mailchimp.lists.subscribe(MAILCHIMP-LIST-ID, 
    #                { "email" => email})
  end
end
