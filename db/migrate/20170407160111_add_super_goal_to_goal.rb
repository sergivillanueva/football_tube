class AddSuperGoalToGoal < ActiveRecord::Migration
  def change
    add_column :goals, :super_goal, :boolean
  end
end
