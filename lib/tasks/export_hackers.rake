desc 'Export the hackers'
task :exportHackers => :environment do
  Hacker.all.each do |h|
    ap h
  end
end
