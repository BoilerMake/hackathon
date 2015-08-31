class SlackIntegrationsController < ApplicationController
  skip_before_action :require_login
  before_action :auth

  def applicants
    str_rep = ""
    if params[:text] == "by_school"
      result = School.select('count(schools.id) as applicant_count, name')
              .joins(:users)
              .group('schools.name')
              .order('applicant_count DESC')
              .limit(10)

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
      application_completed_count = Hacker.all.select(&:application_completed?).count
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
