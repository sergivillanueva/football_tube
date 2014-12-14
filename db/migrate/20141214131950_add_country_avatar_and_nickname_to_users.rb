class AddCountryAvatarAndNicknameToUsers < ActiveRecord::Migration
  def change
  	change_table :users do |t|
  	  t.string :country
  	  t.string :avatar 
  	  t.string :nickname
  	end
  end
end
