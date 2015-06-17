class AddBadgeIdToApplication < ActiveRecord::Migration
  def change
    add_column :applications, :badge_id, :string
  end
end
