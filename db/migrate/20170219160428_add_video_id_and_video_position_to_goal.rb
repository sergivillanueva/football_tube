class AddVideoIdAndVideoPositionToGoal < ActiveRecord::Migration
  def change
    add_reference :goals, :video, index: true
    add_column :goals, :video_start_position, :integer
    add_column :goals, :video_end_position, :integer
  end
end
