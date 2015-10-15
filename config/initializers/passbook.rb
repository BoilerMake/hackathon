require 'passbook'

Passbook.configure do |passbook|
  # Path to your wwdc cert file
  passbook.wwdc_cert = Rails.root.join('passbook', 'wwdr.pem')

  # Path to your cert.p12 file
  passbook.p12_certificate = Rails.root.join('passbook', 'boilermake.p12')

  # Password for your certificate
  passbook.p12_password = 'boilermake'
end
