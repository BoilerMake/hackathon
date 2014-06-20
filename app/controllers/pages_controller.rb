class PagesController < ApplicationController
  def welcome
    @hacker = Hacker.new
  end
end
