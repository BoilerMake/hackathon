class InterestSignup < ActiveRecord::Base
  validates_email_format_of :email
  validates_uniqueness_of :email
  #validate :passes_mailchimp_email_check


  def mailchimp_subscribe
    $mailchimp.lists.subscribe $mailchimp_interest_list, { email: email }
    self.in_mailchimp = true
    self.save!
  rescue
    puts "invalid email submitted: #{email}"
  end

  # validations
  # extra network roundtrip makes things too slow
  def passes_mailchimp_email_check
    begin
      $mailchimp.lists.subscribe $mailchimp_test_list,
                                 { email: email },
                                 nil, # merge vars (idk, mailchimp terms)
                                 'html', # email format (doesn't matter)
                                 false, # whether or not double opt-in is sent
                                 false, # throw error if email exists
                                 true, # replace_interests
                                 false # don't send a welcome email
    rescue Exception => e
      puts e
      errors.add :mailchimp_error, e.message
    else
      # if no error, then we sucessfully subscribed, so we should unsubscribe
      $mailchimp.lists.unsubscribe $mailchimp_test_list,
                                   { email: email },
                                   true,
                                   false
    end
  end
end
