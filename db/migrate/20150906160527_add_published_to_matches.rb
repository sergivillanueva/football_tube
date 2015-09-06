class AddPublishedToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :published, :boolean, default: false

    # Publish all current matches
    Match.update_all(published: true)
  end
end
