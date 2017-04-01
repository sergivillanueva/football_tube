class AddHeaderFreeKickAndOutsideTheBoxToGoal < ActiveRecord::Migration
  def change
    add_column :goals, :header, :boolean
    add_column :goals, :free_kick, :boolean
    add_column :goals, :outside_the_box, :boolean
  end
end
