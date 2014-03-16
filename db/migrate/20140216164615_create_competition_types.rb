class CreateCompetitionTypes < ActiveRecord::Migration
  def change
    create_table :competition_types do |t|
   		t.string :name

   		t.timestamps
    end
  end
end
