json.array!(@users) do |user|
  json.extract! user, :id, :first_name, :last_name, :school_id, :team_id, :email, :gender, :expected_graduation, :github, :tshirt_size, :cell_phone, :linkedin, :dietary_restrictions, :previous_experience, :essay
  json.url user_url(user, format: :json)
end
