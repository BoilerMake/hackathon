class ChangeGradToInteger < ActiveRecord::Migration
  def change
    remove_column :applications, :expected_graduation
    add_column :applications, :expected_graduation, :integer
  end
end
