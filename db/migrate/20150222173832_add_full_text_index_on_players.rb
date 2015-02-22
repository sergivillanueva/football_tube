class AddFullTextIndexOnPlayers < ActiveRecord::Migration
  def change
  	add_index :players, [:name, :full_name], name: 'name_full_name', type: :fulltext
  end
end
