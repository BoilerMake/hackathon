class TeamMailer < ActionMailer::Base
  add_template_helper(TeamHelper)
  default from: DEFAULT_EMAIL

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.team_mailer.invite_hacker.subject
  #
  def invite_hacker(email, team, current_user)
    # you can pass these variables into the text file for the email.
    # I'm pretty sure that you can chang the .text.haml file to .html.haml file
    # in some way to actually implement the styling.
    @team = team
    pronoun = 'his or her';
    gender = current_user.application.gender
    if gender.present?
      if gender == 'Female'
        pronoun = 'her'
      elsif gender == 'Male'
        pronoun = 'his'
      end
    end
    @name = current_user.first_name ? current_user.first_name : current_user.email
    mail(to: email, subject: "#{@name} wants you to join #{pronoun} #{HACKATHON} team!")
  end
end
