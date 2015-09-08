class AddLatLngToSchools < ActiveRecord::Migration
  def change
  	add_column :schools, :lat, :string
  	add_column :schools, :lng, :string
  end
end
