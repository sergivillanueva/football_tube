class ChangeGoalPlayerAssociation < ActiveRecord::Migration
  def change
  	remove_column :goals, :player_participation_id
  	add_column :goals, :player_id, :integer
  end
end
