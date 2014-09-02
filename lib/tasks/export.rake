namespace :export do
  namespace :hackers do
    desc 'gets hacker\'s emails from target schools'
    task :target => :environment do
      target_schools = get_target_schools

      target_emails = target_schools.collect do |school|
        school.users.collect do |hacker|
          hacker.email
        end
      end

      puts target_emails.join ','
    end

    desc 'gets hackers from non-target schools'
    task :nontarget => :environment do
      all_schools    = School.all
      target_schools = get_target_schools
      nontarget = all_schools - target_schools

      nontarget_emails = nontarget.collect do |school|
        school.users.collect do |hacker|
          hacker.email
        end
      end.keep_if {|email| email.present?}

      puts nontarget_emails.join ','
    end

    desc 'gets all hackers basic info from all schools'
    task :all => :environment do
      puts "id, first_name, last_name, school, team_id, email"
      Hacker.all.each do |h|
        school_name = ''
        if h[:school_id].present?
          school_name = School.find(h[:school_id]).name
        end
        puts "#{h[:id]}, #{h[:first_name]}, #{h[:last_name]}, #{school_name}, #{h[:team_id]}, #{h[:email]}"
      end
    end
  end
end

def get_target_schools
  target_schools = []
  target_schools << School.find_by(name: 'University of Illinois-Urbana-Champaign (IL)')
  target_schools << School.find_by(name: 'Purdue University (IN)')
  target_schools << School.find_by(name: 'Rose-Hulman Institute of Technology (IN)')
  target_schools << School.find_by(name: 'Ohio State University (OH)')
  target_schools << School.find_by(name: 'University of Wisconsin-Madison (WI)')
  target_schools << School.find_by(name: 'University of Cincinnati (OH)')
  target_schools << School.find_by(name: 'University of Maryland - College Park (MD)')
  target_schools << School.find_by(name: 'University of Michigan (MI)')
  if Rails.env.production?
    target_schools << School.find(1688)
  else
    target_schools << School.find_by(name: 'Univeristy of Waterloo (INT)')
  end
  target_schools << School.find_by(name: 'Northwestern University (IL)')
  target_schools << School.find_by(name: 'Massachusetts Institute of Technology (MA)')
  target_schools << School.find_by(name: 'Carnegie Mellon University (PA)')
  target_schools << School.find_by(name: 'University of California-Los Angeles (CA)')
  target_schools << School.find_by(name: 'McGill University (INT)')
  target_schools << School.find_by(name: 'Pennsylvania State University (PA)')
  target_schools << School.find_by(name: 'University of California-Berkeley (CA)')
  target_schools << School.find_by(name: 'University of Iowa (IA)')

  return target_schools
end
