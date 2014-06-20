class RemoveFieldsFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :gender, :string
    remove_column :users, :expected_graduation, :datetime
    remove_column :users, :github, :string
    remove_column :users, :tshirt_size, :string
    remove_column :users, :cell_phone, :string
    remove_column :users, :linkedin, :string
    remove_column :users, :dietary_restrictions, :string
    remove_column :users, :previous_experience, :text
    remove_column :users, :essay, :text
  end
end
