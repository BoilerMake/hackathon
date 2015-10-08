class AddTransportationMethodIdToSchool < ActiveRecord::Migration
  def change
    add_column :schools, :transportation_method_id, :integer
  end
end
