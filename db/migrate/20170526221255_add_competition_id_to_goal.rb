class AddCompetitionIdToGoal < ActiveRecord::Migration
  def change
    add_reference :goals, :competition, index: true
  end
end
