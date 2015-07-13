class AddNewFieldsToApplication < ActiveRecord::Migration
  def change
    add_column :applications, :major, :string
    add_column :applications, :degree, :string
    add_column :applications, :essay1, :text
    add_column :applications, :essay2, :text
    add_column :applications, :race, :string
    add_column :applications, :ethnicity, :string
    add_column :applications, :grad_date, :string
    add_column :applications, :job_interest, :string
    add_column :applications, :job_date, :string
  end
end
