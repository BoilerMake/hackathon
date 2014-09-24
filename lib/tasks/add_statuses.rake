desc 'Add hacker statuses'
task :addStatuses => :environment do
  fn = File.join(Rails.root, 'lib', 'assets','statuses.txt')
  hackers = File.open(fn, 'r').read
  hackers.split("\n").each do |hacker|
    id = hacker.split("\t")[0]
    status = hacker.split("\t")[1]
    @u = User.find(id)
    @u.status = status
    @u.save
    puts "#{id} has been saved"
  end
end
