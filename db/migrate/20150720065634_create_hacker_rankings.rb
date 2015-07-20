class CreateHackerRankings < ActiveRecord::Migration
  def change
    create_table :hacker_rankings do |t|
      t.integer :exec_id
      t.integer :hacker_id
      t.integer :ranking

      t.timestamps
    end
  end
end
