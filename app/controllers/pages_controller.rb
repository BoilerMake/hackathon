class PagesController < ApplicationController
  skip_before_action :require_login, :store_session

  def welcome
    @hacker = Hacker.new
  end
end
