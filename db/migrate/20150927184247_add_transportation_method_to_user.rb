class AddTransportationMethodToUser < ActiveRecord::Migration
  def change
    add_column :users, :transportation_method, :string
  end
end
