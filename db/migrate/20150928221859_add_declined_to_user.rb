class AddDeclinedToUser < ActiveRecord::Migration
  def change
    add_column :users, :declined, :boolean, default: false
  end
end
