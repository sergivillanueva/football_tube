class AddingCountryIdToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :country_id, :integer
  end
end
