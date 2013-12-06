class CreatePlayerParticipations < ActiveRecord::Migration
  def change
    create_table :player_participations do |t|
      t.belongs_to :match
      t.belongs_to :player
      t.string :role
      t.string :side

      t.timestamps
    end
  end
end
