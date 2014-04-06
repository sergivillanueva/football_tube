class AddSeasonToMatch < ActiveRecord::Migration
  def change
  	add_column :matches, :season, :string
  end
end
