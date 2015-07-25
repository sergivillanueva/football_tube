class AddSlugToCompetitions < ActiveRecord::Migration
  def change
  	add_column :competitions, :slug, :string
    add_index  :competitions, :slug, unique: true
  end
end
