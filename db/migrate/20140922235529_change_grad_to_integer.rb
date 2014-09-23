class ChangeGradToInteger < ActiveRecord::Migration
  def change
    change_column :applications, :expected_graduation, :integer
  end
end
