class PagesController < ApplicationController
  skip_before_action :require_login

  def welcome
    @hacker            = Hacker.new
    @should_skip_intro = params[:should_skip_intro]
    @interest_signup   = InterestSignup.new
    @updates           = Update.all.order('created_at DESC')
  end

  def schedule
    redirect_to "#{root_url}#schedule"
  end
end
