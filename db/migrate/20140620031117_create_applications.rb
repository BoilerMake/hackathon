class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.string :gender
      t.datetime :expected_graduation
      t.string :github
      t.string :tshirt_size
      t.string :cell_phone
      t.string :linkedin
      t.string :dietary_restrictions
      t.text :previous_experience
      t.text :essay

      t.timestamps
    end
  end
end
