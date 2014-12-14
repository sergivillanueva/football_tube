class RenameCountryAndNicknameOnUsers < ActiveRecord::Migration
  def change
  	rename_column :users, :nickname, :nick_name
  	remove_column :users, :country 
  	change_table :users do |t|
  	  t.references :country
  	end
  end
end
