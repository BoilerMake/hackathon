class HackerInvitationsController < ApplicationController
  def new
  end

  def create
    team = Team.find(current_user.team_id)

    invitee_one = params[:email_one]
    invitee_two = params[:email_two]
    invitee_three = params[:email_three]

    team.send_hacker_invitation(invitee_one) if invitee_one
    team.send_hacker_invitation(invitee_two) if invitee_two
    team.send_hacker_invitation(invitee_three) if invitee_three

    redirect_to team_path(team)
  end
end
