S3FileField.config do |c|
  c.access_key_id = "AKIAI5VU4VHOMIEYXJGA"
  c.secret_access_key = "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"
  c.bucket = "boilermake-resumes"
  c.key_starts_with = 'resume/'
  c.max_file_size = 25.megabytes
  c.acl = "public-read"
  # c.conditions = []
  # 
  # c.ssl = true # if true, force SSL connection
end
