class ChangeLegToStageOnMatch < ActiveRecord::Migration
  def change
  	rename_column :matches, :leg, :stage
  end
end
