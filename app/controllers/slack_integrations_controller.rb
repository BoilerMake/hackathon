class SlackIntegrationsController < ApplicationController
  skip_before_action :require_login
  before_action :auth

  def hackers
    str_rep = ""
    split_text = params[:text].split " "

    if split_text.first == 'accepted'
      str_rep = Hacker.where(status: "Accepted").count.to_s
    elsif split_text.first == 'waitlisted'
      str_rep = Hacker.where(status: "Standby").count.to_s
    elsif split_text.first == 'rejected'
      str_rep = Hacker.where(status: "Rejected").count.to_s
    elsif split_text.first == 'cant_attend'
      str_rep = Hacker.where(status: "Accepted", declined: true).count.to_s
    elsif split_text.first == 'attending'
      str_rep = Hacker.where(status: "Accepted", confirmed: true).count.to_s
    end

    render text: str_rep
  end

  def applicants
    str_rep = ""
    split_text = params[:text].split " "
    if split_text.first == "by_school"
      result = [];
      if split_text[1] == "min_hackers" && split_text[2]
        result = School.select('count(schools.id) as applicant_count, name')
                .joins(:users)
                .group('schools.name')
                .order('applicant_count DESC')
                .having("count(schools.id) >= ?", split_text[2].to_i)
      else
        result = School.select('count(schools.id) as applicant_count, name')
                .joins(:users)
                .group('schools.name')
                .order('applicant_count DESC')
                .limit(10)
      end

      result.each do |school|
        str_rep = str_rep + "\n#{school.name}: #{school.applicant_count}\n"
      end
    elsif params[:text] == "by_gender"
      male_count      = Application.where(gender: "Male").count
      female_count    = Application.where(gender: "Female").count
      other_count     = Application.where(gender: "Other").count
      nospecify_count = Application.where(gender: "Prefer not to specify").count

      str_rep = "Males: #{male_count} \n
                 Females: #{female_count} \n
                 Other: #{other_count} \n
                 Prefer Not to Specify : #{nospecify_count}"
    elsif params[:text] == ""
      application_count = Application.all.count
      application_completed_count = Hacker.application_completed.count
      registered_count = Hacker.all.count
      str_rep = "Registered: #{registered_count} \n
                 Started an application: #{application_count} \n
                 Completed an application: #{application_completed_count} \n"
    end

    render text: str_rep
  end

  private

  def auth
    allowed = [ 'g29b5FaoCtlcoNey5wi7XkAr' ]

    if allowed.index(params[:token]).nil?
      render text: "not allowed", status: 401
    end
  end
end
