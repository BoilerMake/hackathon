desc 'Add hacker statuses'
task :addStatuses => :environment do
  fn = File.join(Rails.root, 'lib', 'assets','statuses.txt')
  hackers = File.open(fn, 'r').read
  hackers.split("\n").each do |hacker|
    id = hacker.split("\t")[0]
    status = hacker.split("\t")[1]
    begin
      @u = User.find(id)
      @u.status = status
      @u.save
      puts "#{id} has been saved"
    rescue ActiveRecord::RecordNotFound
      puts "ERROR: #{id} was not found"
    end
  end
end
