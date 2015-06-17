class CreateInterestSignups < ActiveRecord::Migration
  def change
    create_table :interest_signups do |t|
      t.string :email

      t.timestamps
    end
  end
end
