class ChangeTeamNationalityToCountryCode < ActiveRecord::Migration
  def change
    rename_column :teams, :nationality, :country_code
  end
end
