class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name, null: false
      t.string :nick_names
      t.string :emblem
      t.string :nationality
      
      t.timestamps
    end
  end
end
