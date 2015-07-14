class RemoveOldFieldsFromApplication < ActiveRecord::Migration
  def change
    remove_column :applications, :linkedin
    remove_column :applications, :previous_experience
    remove_column :applications, :expected_graduation
    remove_column :applications, :address_line_one
    remove_column :applications, :address_line_two
    remove_column :applications, :city
    remove_column :applications, :state
    remove_column :applications, :zip_code
    remove_column :applications, :badge_id
    remove_column :applications, :essay
  end
end