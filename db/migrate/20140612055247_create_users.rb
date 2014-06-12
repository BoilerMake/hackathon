class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.integer :school_id
      t.integer :team_id
      t.string :email
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
