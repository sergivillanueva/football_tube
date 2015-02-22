class AddFullTextIndexOnPlayers < ActiveRecord::Migration
  def self.up
	execute 'ALTER TABLE players ENGINE = MyISAM'
  	add_index :players, [:name, :full_name], name: 'name_full_name', type: :fulltext
  end
  def self.down
  	execute 'ALTER TABLE players ENGINE = InnoDB'
	execute 'DROP INDEX name_full_name ON players'
  end
end
