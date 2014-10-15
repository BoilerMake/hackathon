class PagesController < ApplicationController
  skip_before_action :require_login

  def welcome
    @hacker = Hacker.new
  end

  def schedule
    redirect_to root_path, notice: 'Schedule coming soon!'
  end
end
