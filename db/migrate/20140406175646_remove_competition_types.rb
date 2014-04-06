class RemoveCompetitionTypes < ActiveRecord::Migration
  def change
  	drop_table :competition_types
  	remove_column :competitions, :competition_type_id
  end
end
