class VisualizationController < ApplicationController
  skip_before_action :require_login

  def index
    @school_info = Hash.new

    Hacker.where.not(school_id: nil).each do |hacker|
      school = hacker.school
      if school.lat.nil? || school.lng.nil?
        school.populate_coordinates!
      end

      if @school_info[school.name].present?
        @school_info[school.name][:count] = @school_info[school.name][:count] + 1
      else
        @school_info[school.name] = {
          count: 1,
          lat: school.lat,
          lng: school.lng,
          state: school.state
        }
      end
    end
  end

end
