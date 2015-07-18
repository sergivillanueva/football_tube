class AddFavouriteTeamToUser < ActiveRecord::Migration
  def change
    add_column :users, :favourite_team_id, :integer
		add_index :users, :favourite_team_id
  end
end
