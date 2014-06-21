class TeamMailer < ActionMailer::Base
  default from: "purduehonors26@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.team_mailer.invite_hacker.subject
  #
  def invite_hacker(email)
    mail(to: email, subject: "NAME has invited you to join their BoilerMake team!")
  end
end
