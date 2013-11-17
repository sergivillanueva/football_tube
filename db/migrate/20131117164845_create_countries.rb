class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :name
      t.string :code
      t.integer :priority, default: 0, limit: 1
      
    end
  end
end
