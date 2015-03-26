class AddStateAndCountryToSchool < ActiveRecord::Migration
  def change
    add_column :schools, :state, :string
    add_column :schools, :country, :string
  end
end
