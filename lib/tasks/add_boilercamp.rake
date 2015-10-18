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

    end

    school_id = purdue.id
    if row['school_id'].present?
      school_id = row['school_id']
    end

    checked_in = hacker.checked_in_time
    if row['Checked In'].present? && checked_in.nil?
      checked_in = Time.now
    end

    hacker.update first_name: row['First Name'],
                  last_name: row['Last Name'],
                  status: 'Accepted',
                  school_id: school_id,
                  checked_in_time: checked_in,
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
