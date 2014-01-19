class AddLanguageToMatch < ActiveRecord::Migration
  def change
    add_column :matches, :language, :string
  end
end
