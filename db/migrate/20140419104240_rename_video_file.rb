class RenameVideoFile < ActiveRecord::Migration
  def change
  	rename_column :videos, :file, :source_file
  end
end
