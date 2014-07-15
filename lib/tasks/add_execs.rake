desc 'Creates user accounts for all exec board members'
task :addExecs => :environment do
  fn = File.join(Rails.root, 'lib', 'assets','execs.txt')
  execs = File.open(fn, 'r').read
  execs.split("\n").each do |email|
    if !Exec.find_by(email: email)
      pass = SecureRandom.urlsafe_base64
      exec = Exec.create(email: email, password: pass, password_confirmation: pass)
      exec.send_password_reset
      puts "Account for #{email} was created"
    end
  end
end
