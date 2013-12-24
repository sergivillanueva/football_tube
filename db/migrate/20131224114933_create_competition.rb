class CreateCompetition < ActiveRecord::Migration
  def change
    create_table :competitions do |t|
      t.string :name
      
      t.timestamps
    end
  end
end
