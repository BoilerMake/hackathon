desc 'Updates all BoilerCamp attendees'
task :addBoilerCamp => :environment do
  fn = File.join(Rails.root, 'lib', 'assets','boilercamp.csv')
  csv = CSV.read(fn, headers: true)

  purdue = School.find_by(name: 'Purdue University')

  csv.each do |row|
    hacker = Hacker.find_by email: row['Email']
    if !hacker

      pass = SecureRandom.urlsafe_base64
      hacker = Hacker.create! email: row['Email'],
                              password: pass,
                              password_confirmation: pass
      puts "Hacker '#{hacker.email}' \t created!"

      hacker.build_application

      hacker.send_password_reset
    end

    hacker.update first_name: row['First Name'],
                  last_name: row['Last Name'],
                  status: 'Accepted',
                  school_id: purdue.id,
                  confirmed: true,
                  email: row['Email'],
                  application_attributes: {
                    gender: row['Gender'],
                    resume: '',
                    major: 'N/A',
                    dietary_restrictions: row['Dietary Restrictions'],
                    tshirt_size: row['T-shirt Size']
                  }

    puts "Hacker '#{hacker.email}' \t updated!"
  end
end
