class ExecsController < ApplicationController
  load_and_authorize_resource
  def applied
    @count = Hacker.all.count
  end

  def sticker_recipients
    deadline = Time.parse('July 15th 2014 11:59pm PST')
    @hackers = Hacker.where('created_at < ?', deadline ).select do |h|
      h.eligible_for_sticker?
    end
    respond_to do |format|
      format.json { render @hackers }
      format.html { render 'sticker_recipients' }
    end
  end

  def hackers_for
    @school = School.find params[:school_id]
    @hackers = @school.users
  end


  def dashboard
    @applied_count = Hacker.all.count
    @schools = Hacker.all.map{ |h| h.school }.keep_if{ |h| h.present? }.uniq

    @school_count = @schools.count

    @focus_schools = []
    @focus_schools << School.find_by(name: 'University of Illinois-Urbana-Champaign (IL)')
    @focus_schools << School.find_by(name: 'Purdue University (IN)')
    @focus_schools << School.find_by(name: 'Rose-Hulman Institute of Technology (IN)')
    @focus_schools << School.find_by(name: 'Ohio State University (OH)')
    @focus_schools << School.find_by(name: 'University of Wisconsin-Madison (WI)')
    @focus_schools << School.find_by(name: 'University of Cincinnati (OH)')
    @focus_schools << School.find_by(name: 'University of Maryland - College Park (MD)')
    @focus_schools << School.find_by(name: 'University of Michigan (MI)')
    @focus_schools << School.find_by(name: 'Univeristy of Waterloo (INT)')
    @focus_schools << School.find_by(name: 'Northwestern University (IL)')
    @focus_schools << School.find_by(name: 'Massachusetts Institute of Technology (MA)')
    @focus_schools << School.find_by(name: 'Carnegie Mellon University (PA)')
    @focus_schools << School.find_by(name: 'University of California-Los Angeles (CA)')
    @focus_schools << School.find_by(name: 'McGill University (INT)')
    @focus_schools << School.find_by(name: 'Pennsylvania State University (PA)')
    @focus_schools << School.find_by(name: 'University of California-Berkeley (CA)')
    @focus_schools << School.find_by(name: 'University of Iowa (IA)')

  end

  private
  def difference_in_days earliest, latest
    ( (latest - earliest) / (60 * 60 * 24) ).floor
  end
end
