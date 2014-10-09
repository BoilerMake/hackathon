desc 'Reviews schools on hackers'
task :resetSchools => :environment do
  fn = File.join(Rails.root, 'lib', 'assets','all-hackers_schools.csv')
  hackers = File.open(fn, 'r').read
  hackers.split("\n").each do |hacker|
    id, school = hacker.split(",")
    begin
      u = User.find(id)
      if u.school_id.nil? && u.confirmed?
        school = School.find_by(name:school)
        if school.present?
          u.school_id = school.id
          u.save
          puts "#{id} has been saved"
        end
      end
    rescue ActiveRecord::RecordNotFound
      puts "ERROR: #{id} was not found"
    end
  end
end
