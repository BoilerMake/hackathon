class TeamMailer < ActionMailer::Base
  add_template_helper(TeamHelper)
  default from: DEFAULT_EMAIL

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.team_mailer.invite_hacker.subject
  #
  def invite_hacker(email, team, current_user)
    @team = team
    name = current_user.first_name ? current_user.first_name : 'A friend'
    mail(to: email, subject: "#{name} wants you to join a #{HACKATHON} team!")
  end
end
