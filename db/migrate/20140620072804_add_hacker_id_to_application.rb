class AddHackerIdToApplication < ActiveRecord::Migration
  def change
    add_column :applications, :hacker_id, :integer
  end
end
