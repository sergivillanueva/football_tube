class AddKindToCompetition < ActiveRecord::Migration
  def change
  	add_column :competitions, :kind, :string
  end
end
