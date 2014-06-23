desc 'Adds schools to the db'
task :addSchools => :environment do
  fn = File.join(Rails.root, 'lib', 'assets','schools.txt')
  schools = File.open(fn, 'r').read
  schools.split("\n").each do |school|
    if !School.find_by(name: school)
      puts School.create(name: school)
      puts "#{school} was created"
    end
  end
end
