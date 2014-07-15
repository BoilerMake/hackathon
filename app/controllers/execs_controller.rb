class ExecsController < ApplicationController
  load_and_authorize_resource
  def applied
    @count = Hacker.all.count
  end

  def dashboard
    @applied_count = Hacker.all.count
    @schools = Hacker.all.map{ |h| h.school }.keep_if{ |h| h.present? }.uniq

    @school_count = @schools.count
  end

  private
  def difference_in_days earliest, latest
    ( (latest - earliest) / (60 * 60 * 24) ).floor
  end
end
