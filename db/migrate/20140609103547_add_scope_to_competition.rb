class AddScopeToCompetition < ActiveRecord::Migration
  def change
    add_column :competitions, :scope, :string
  end
end
