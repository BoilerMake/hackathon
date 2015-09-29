class SponsorsController < ApplicationController
  load_and_authorize_resource

  def resume_portal
  end

  def hackers
    @hackers = Hacker.where(status: 'Accepted')
  end
end
