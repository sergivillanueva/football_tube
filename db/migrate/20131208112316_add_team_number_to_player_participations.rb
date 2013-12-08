class AddTeamNumberToPlayerParticipations < ActiveRecord::Migration
  def change
    add_column :player_participations, :team_number, :integer, limit: 1
  end
end
