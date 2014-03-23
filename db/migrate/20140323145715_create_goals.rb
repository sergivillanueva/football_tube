class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.integer :player_participation_id
      t.integer :match_id
      t.integer :minute

      t.timestamps
    end
  end
end
