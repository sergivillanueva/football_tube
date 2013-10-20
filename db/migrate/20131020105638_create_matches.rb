class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :home_score, limit: 1, null: false
      t.integer :away_score, limit: 1, null: false
      t.date :playing_date
      t.integer :home_team_id, :references => :teams
      t.integer :away_team_id, :references => :teams
      
      t.timestamps
    end
  end
end
