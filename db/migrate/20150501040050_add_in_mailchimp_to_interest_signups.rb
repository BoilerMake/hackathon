class AddInMailchimpToInterestSignups < ActiveRecord::Migration
  def change
    add_column :interest_signups, :in_mailchimp, :boolean, default: false
  end
end
