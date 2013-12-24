class AddVenueToMatch < ActiveRecord::Migration
  def change
    add_column :matches, :venue, :string
  end
end
