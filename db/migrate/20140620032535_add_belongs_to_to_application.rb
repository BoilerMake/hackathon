class AddBelongsToToApplication < ActiveRecord::Migration
  def change
    add_reference :applications, :user, index: true
  end
end
