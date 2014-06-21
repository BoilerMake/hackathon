class AddSecretKeyToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :secret_key, :string
  end
end
