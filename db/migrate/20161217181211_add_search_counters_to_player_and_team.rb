class AddSearchCountersToPlayerAndTeam < ActiveRecord::Migration
  def change
    add_column :players, :visits_counter, :integer, default: 0
    add_column :teams, :visits_counter, :integer, default: 0
  end
end
