class ExecsController < ApplicationController
  load_and_authorize_resource
  def applied
    @count = Hacker.all.count
  end

  def dashboard
    @applied_count = Hacker.all.count
    schools = Hacker.all.collect do |h|
      if h.school.present?
        h.school
      end
    end
    @school_count = schools.uniq.count
  end
end
