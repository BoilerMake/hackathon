class AddShortMessageToUpdates < ActiveRecord::Migration
  def change
    add_column :updates, :short_message, :string
  end
end
