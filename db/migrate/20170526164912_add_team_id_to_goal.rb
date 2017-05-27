class AddTeamIdToGoal < ActiveRecord::Migration
  def change
    add_reference :goals, :team, index: true
  end
end
