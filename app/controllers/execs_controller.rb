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

  def incomplete_hackers
    require 'csv'
    @csv_string = CSV.generate do |csv|
      csv << ['id', 'fname', 'lname', 'email', 'school']
      Hacker.application_incomplete.each do |h|
        school_name = ''
        if h[:school_id].present? && h[:school_id] != -1
          school_name = School.find(h[:school_id]).name
        end
        csv << [h.id,
                h.first_name,
                h.last_name,
                h.email,
                school_name]
      end
    end
    send_data @csv_string,
              :filename => "application_incomplete_hackers.csv",
              :type => "text/csv"
  end

  def shirts
    @shirt_sizes = ['Small', 'Medium', 'Large', 'XL', 'XXL']
    @shirts = Hash.new
    @shirt_sizes.each do |size|
      @shirts[size] = Hacker.joins(:application).where(applications: {tshirt_size: size}).count
    end
  end

  def export
    require 'csv'
    @csv_string = CSV.generate do |csv|
      csv << ['id', 'fname', 'lname', 'email', 'school', 'created_at', 'updated_at']
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
                h.created_at,
                h.updated_at]
      end
    end
    send_data @csv_string,
              :filename => "all-hackers.csv",
              :type => "text/csv"
  end

  def hackers_for
    @school = School.find params[:school_id]
    @hackers = @school.users
  end


  def dashboard
    @execs = Exec.all
    @confirmed_count = Hacker.where(confirmed: true).count
    @application_count = Application.all.count
    @application_completed_count = Hacker.application_completed.count
    @registered_count = Hacker.all.count
    @school_count = Hacker
      .uniq
      .where.not(school_id: nil)
      .where.not("school_id = -1").count

  end

  def ranker
    found = nil
    Hacker.application_completed.each do |hacker|
      have_ranked = (HackerRanking.where(exec: current_user).where(hacker: hacker).count ==1)
      if(!have_ranked && hacker.hacker_ranking.count<3)
        found = hacker
        break
      end
    end
    if(found == nil)
      render html: "looks like everyone is ranked!"
    elsif
      redirect_to :action => "hacker_detail", :hacker_id => found.id
    end
  end
  def hacker_detail
    @hacker = Hacker.find params[:hacker_id]
    @hacker_github_info = get_github_info @hacker

    query = HackerRanking.where("hacker_id = ? and exec_id = ?", @hacker.id, current_user.id)
    if(query.any?)
      @hacker_ranking = query.first
    else
      @hacker_ranking = HackerRanking.new(exec_id: current_user.id, hacker_id: @hacker.id)
    end
  end

  private
  def difference_in_days earliest, latest
    ( (latest - earliest) / (60 * 60 * 24) ).floor
  end
  def get_github_info(hacker)
    require 'uri'
    require 'net/http'
    info = Hash.new

    if(@hacker.application.github==nil || @hacker.application.github=="")
      return nil
    end
    github_username=URI(@hacker.application.github).path.split('/').last

    parsed_url = URI.parse("https://api.github.com/users/#{github_username}")
    http = Net::HTTP.new(parsed_url.host, parsed_url.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(parsed_url.request_uri)
    request.basic_auth ENV['github_api_username'], ENV['github_api_secret']
    info['profile']= ActiveSupport::JSON.decode(http.request(request).body)

    parsed_url = URI.parse("https://api.github.com/users/#{github_username}/repos?sort=updated")
    http = Net::HTTP.new(parsed_url.host, parsed_url.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(parsed_url.request_uri)
    request.basic_auth ENV['github_api_username'], ENV['github_api_secret']
    info['repos']= ActiveSupport::JSON.decode(http.request(request).body)

    return info
  end
end
