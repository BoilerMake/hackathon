class AddShouldTextToUpdates < ActiveRecord::Migration
  def change
    add_column :updates, :should_text, :boolean, default: true
  end
end
