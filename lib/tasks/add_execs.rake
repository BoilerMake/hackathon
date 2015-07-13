desc 'Creates user accounts for all exec board members'
task :addExecs => :environment do
  fn = File.join(Rails.root, 'lib', 'assets','execs.txt')
  execs = File.open(fn, 'r').read
  execs.split("\n").each do |email|

    exec = User.find_by email: email
    puts "account for #{email} is #{exec ? 'found': 'not found'}"
    if exec.present? && exec.hacker?
      exec.destroy
      exec = nil
    end
    if exec.nil?
      pass = SecureRandom.urlsafe_base64
      exec = Exec.create! email: email,
                          password: pass,
                          password_confirmation: pass
      exec.send_password_reset
      puts "Account for #{email} was created"
    end
  end
end
