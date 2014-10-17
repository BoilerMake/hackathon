class PagesController < ApplicationController
  skip_before_action :require_login

  def welcome
    @hacker = Hacker.new
    @updates = Update.all.order('created_at DESC')
  end

  def minecraft
  end

  def schedule
    redirect_to "#{root_url}#schedule"
  end
end
