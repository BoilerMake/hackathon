require 'csv'

desc 'Adds schools to the db'
task :addSchools => :environment do
  fn = File.join(Rails.root, 'lib', 'assets','schools.csv')
  schools_csv = File.open(fn, 'r').read
  schools = CSV.parse(schools_csv, headers: true)
  schools.each do |s|
    school = s.to_hash
    school_id = School.find_by(name: school["name"],
                               state: school["state"],
                               country: school["country"] )
    if school_id == nil
      School.create school
      puts "#{school["name"]} from #{school["state"]}, #{school["country"]} was created"
    else
      School.update school_id, school
      puts "#{school["name"]} from #{school["state"]}, #{school["country"]} was updated"
    end
  end
end
