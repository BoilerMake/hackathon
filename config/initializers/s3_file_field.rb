S3FileField.config do |c|
  c.access_key_id = "AKIAIV5Y6ZS7SSXRQO4A"
  c.secret_access_key = "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"
  c.bucket = "boilermake"
  c.key_starts_with = 'resume/'
  # c.expiration = 10.hours.from_now.utc.iso8601
  # c.max_file_size = 50.megabytes
  # c.conditions = []
  # 
  # c.ssl = true # if true, force SSL connection
end