class AddCategoryToSchool < ActiveRecord::Migration
  def change
    add_column :schools, :category, :string
    add_column :schools, :is_target, :boolean
  end
end
