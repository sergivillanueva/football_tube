class AddCompetitionTypeIdToCompetitions < ActiveRecord::Migration
  def change
  	change_table :competitions do |t|
  	  t.integer :competition_type_id
  	  t.integer :country_id
  	end
  end
end
