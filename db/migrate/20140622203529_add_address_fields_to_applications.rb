class AddAddressFieldsToApplications < ActiveRecord::Migration
  def change
    add_column :applications, :address_line_one, :string
    add_column :applications, :address_line_two, :string
    add_column :applications, :city, :string
    add_column :applications, :state, :string
    add_column :applications, :zip_code, :string
  end
end
