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

  def shirts
    @shirt_sizes = ['Small', 'Medium', 'Large', 'XL', 'XXL']
    @shirts = Hash.new
    @shirt_sizes.each do |size|
      @shirts[size] = Hacker.joins(:application).where(applications: {tshirt_size: size}).count
    end
  end

  def exportall
    require 'csv'
    @csv_string = CSV.generate do |csv|
      csv << ['id', 'fname', 'lname', 'email', 'school', 'team', 'status', 'confirmed']
      Hacker.all.each do |h|
        school_name = ''
        team_id     = 0
        if h[:school_id].present? && h[:school_id] != -1
          school_name = School.find(h[:school_id]).name
        end
        if h.team.present?
          team_id = h.team.id
        end
        csv << [h.id,
                h.first_name,
                h.last_name,
                h.email,
                school_name,
                team_id,
                h.status,
                h.confirmed]
      end
    end
    send_data @csv_string,
              :filename => "all-hackers.csv",
              :type => "text/csv"
  end

  def export
    require 'csv'
    @csv_string = CSV.generate do |csv|
      csv << ['id', 'name', 'github', 'school', 'essay', 'team']
      Hacker.all.each do |h|
        school_name = ''
        prev_exp    = ''
        team_id     = 0
        if h[:school_id].present? && h[:school_id] != -1
          school_name = School.find(h[:school_id]).name
        end
        if h.team.present?
          team_id = h.team.id
        end
        if h.application.present?
          if h.application.previous_experience.present?
            prev_exp = h.application.previous_experience
          end
            csv << [h.id,
                    h.full_name,
                    h.application.github,
                    school_name,
                    prev_exp,
                    team_id]
        end
      end
    end
    send_data @csv_string,
              :filename => "hackers.csv",
              :type => "text/csv"
  end

  def hackers_for
    @school = School.find params[:school_id]
    @hackers = @school.users
  end


  def dashboard
    @interested_count = InterestSignup.count
    @interested_and_valid_count = InterestSignup.where(in_mailchimp: true).count
    @interested_student_count = InterestSignup.where("email LIKE '%.edu'").count
    @confirmed_count = Hacker.where(confirmed: true).count
    @applied_count = Hacker.all.count
    @applied_student_count = Hacker.where("email LIKE '%.edu'").count
    @schools = Hacker.all.map{ |h| h.school }.keep_if{ |h| h.present? }.uniq.sort_by do |s|
      s.users.count
    end.reverse

    @school_count = @schools.count

  end
  def review
    @hackers = Hacker.all
  end

  def hacker_detail
    @hacker = Hacker.find params[:hacker_id]
    github_username="nickysemenza"
    #todo: parse github username
    require 'net/http'
    parsed_url = URI.parse('https://api.github.com/users/'+github_username)
    http = Net::HTTP.new(parsed_url.host, parsed_url.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(parsed_url.request_uri)
    request.basic_auth 'boilermake-web', 'cff6c84e6672405c31e9e36166bbaa3011d21f4b'
    @hacker_github= ActiveSupport::JSON.decode(http.request(request).body)

    parsed_url = URI.parse('https://api.github.com/users/'+github_username+'/repos?sort=updated')
    http = Net::HTTP.new(parsed_url.host, parsed_url.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(parsed_url.request_uri)
    request.basic_auth 'boilermake-web', 'cff6c84e6672405c31e9e36166bbaa3011d21f4b'
    @hacker_github_repos= ActiveSupport::JSON.decode(http.request(request).body)


    @hacker_ranking = HackerRanking.new
    @hacker_ranking.exec_id=current_user.id
    #todo: how do i do this stuff
  end

  private
  def difference_in_days earliest, latest
    ( (latest - earliest) / (60 * 60 * 24) ).floor
  end
end
