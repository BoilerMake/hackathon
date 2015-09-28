class SponsorsController < ApplicationController
  load_and_authorize_resource

  def resume_portal
    @hackers = Hacker.where(status: 'Accepted')
  end
end
