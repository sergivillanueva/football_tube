class AddOwnGoalToGoal < ActiveRecord::Migration
  def change
  	add_column :goals, :own_goal, :boolean, default: false
  end
end
