class CreateHackerSignups < ActiveRecord::Migration
  def change
    create_table :hacker_signups do |t|
      t.string :email

      t.timestamps
    end
  end
end
