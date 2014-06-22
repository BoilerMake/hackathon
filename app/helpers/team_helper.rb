module TeamHelper
  def invite_url team
    teams_join_url secret_key: team.secret_key
  end
end
