class AddTextSentToUpdates < ActiveRecord::Migration
  def change
    add_column :updates, :text_sent, :string
  end
end
