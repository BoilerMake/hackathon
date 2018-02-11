S3FileField.config do |c|
  c.access_key_id = ""
  c.secret_access_key = ""
  c.bucket = "boilermake-resumes"
  c.key_starts_with = 'resume/'
  c.max_file_size = 25.megabytes
  c.acl = "public-read"
  # c.conditions = []
  # 
  # c.ssl = true # if true, force SSL connection
end
