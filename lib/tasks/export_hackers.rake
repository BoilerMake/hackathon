require 'awesome_print'
desc 'Export the hackers'
task :exportHackers => :environment do
  Hacker.all.each do |h|
    puts "#{h[:id]}, #{h[:first_name]}, #{h[:last_name]}, #{h[:school_id]}, #{h[:team_id]}, #{h[:email]}, #{h[:created_at]}, #{h[:updated_at]}, #{h[:password_digest]}, #{h[:auth_token]}, #{h[:password_reset_token]}, #{h[:password_reset_sent_at]}, #{h[:type]}, #{h.application[:id] if h.application}, #{h.application[:gender] if h.application}, #{h.application[:expected_graduation] if h.application}, #{h.application[:github] if h.application}, #{h.application[:tshirt_size] if h.application}, #{h.application[:cell_phone] if h.application}, #{h.application[:linkedin] if h.application}, #{h.application[:dietary_restrictions] if h.application}, #{h.application[:previous_experience] if h.application}, #{h.application[:essay] if h.application}, #{h.application[:created_at] if h.application}, #{h.application[:updated_at] if h.application}, #{h.application[:hacker_id] if h.application}, #{h.application[:address_line_one] if h.application}, #{h.application[:address_line_two] if h.application}, #{h.application[:city] if h.application}, #{h.application[:state] if h.application}, #{h.application[:zip_code] if h.application}"
  end
end
