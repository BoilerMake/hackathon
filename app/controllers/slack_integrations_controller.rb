class SlackIntegrationsController < ApplicationController
  before_action :auth

  def applicants_by_school
    list = School.select('count(schools.id) as applicant_count, name')
            .joins(:users)
            .group('schools.name')
            .order('applicant_count DESC')
            .limit(10)

    str_rep = list.map do |school|
      "#{school.applicant_count} \t|\t #{school.name}"
    end

    render body: str_rep
  end

  private

  def auth
    allowed = [ 'g29b5FaoCtlcoNey5wi7XkAr' ]

    if allowed.index(params[:token]).nil?
      render status: 401
    end
  end
end
