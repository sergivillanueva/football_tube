class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :file
      t.integer :match_id

      t.timestamps
    end
  end
end
