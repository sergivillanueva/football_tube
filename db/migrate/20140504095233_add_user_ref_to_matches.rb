class AddUserRefToMatches < ActiveRecord::Migration
  def change
    add_reference :matches, :user, index: true
  end
end
