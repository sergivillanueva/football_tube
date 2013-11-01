class ChangeEmblemToLogo < ActiveRecord::Migration
  def change
    rename_column :teams, :emblem, :logo
  end
end
