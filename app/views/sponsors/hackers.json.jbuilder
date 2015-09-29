json.array!(@hackers) do |hacker|
  json.name hacker.full_name
  json.school hacker.school.name
  json.major hacker.application.major
  json.gender hacker.application.gender
  json.email hacker.email
  json.resume url_for(hacker.application.resume)
end
