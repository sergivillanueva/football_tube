class AddSourceFileToGoal < ActiveRecord::Migration
  def change
    add_column :goals, :source_file, :string
  end
end
