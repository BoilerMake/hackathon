class AddCanTextToApplications < ActiveRecord::Migration
  def change
    add_column :applications, :can_text, :boolean, default: true
  end
end
