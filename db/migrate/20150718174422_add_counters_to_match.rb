class AddCountersToMatch < ActiveRecord::Migration
  def change
    add_column :matches, :visualizations_counter, :integer, default: 0
    add_column :matches, :visits_counter, :integer, default: 0
  end
end
