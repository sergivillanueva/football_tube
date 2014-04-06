class AddLegToMatches < ActiveRecord::Migration
  def change
  	add_column :matches, :leg, :string
  end
end
