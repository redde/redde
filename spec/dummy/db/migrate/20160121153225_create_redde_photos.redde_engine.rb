# This migration comes from redde_engine (originally 20160121152706)
class CreateReddePhotos < ActiveRecord::Migration
  def up
  end
  def change
    create_table :redde_photos do |t|
      t.integer :imageable_id
      t.string :imageable_type
      t.integer :position
      t.string :src
      t.string :token

      t.timestamps
    end
    add_index :redde_photos, :imageable_id
    add_index :redde_photos, :imageable_type
    add_index :redde_photos, :token
  end
end
