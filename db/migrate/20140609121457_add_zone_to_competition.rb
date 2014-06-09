class AddZoneToCompetition < ActiveRecord::Migration
  def change
    add_column :competitions, :zone, :string
  end
end
