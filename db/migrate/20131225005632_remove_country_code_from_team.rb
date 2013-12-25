class RemoveCountryCodeFromTeam < ActiveRecord::Migration
  def change
    remove_column :teams, :country_code
  end
end
