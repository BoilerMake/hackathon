desc 'Adds schools to the db'
task :addSchools => :environment do
  schools = File.join(Rails.root, 'lib', 'assets','schools.txt').read
  schools.split('\n').each do |school|
    School.create(name: school) if School.find_by(name: school)
  end
end
