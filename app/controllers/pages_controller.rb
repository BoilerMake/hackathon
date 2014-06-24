class PagesController < ApplicationController
  skip_before_action :require_login

  def welcome
    @hacker = Hacker.new
  end

  def temporary_splash
  end
end
