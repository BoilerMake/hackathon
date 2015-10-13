class AddCheckedInTimeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :checked_in_time, :timestamp
  end
end
