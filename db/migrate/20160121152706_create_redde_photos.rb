class CreateReddePhotos < ActiveRecord::Migration
  def change
    create_table :redde_photos do |t|
      t.integer :imageable_id
      t.string :imageable_type
      t.integer :position
      t.string :src
      t.string :token

      t.timestamps, null: false
    end
    add_index :redde_photos, :imageable_id
    add_index :redde_photos, :imageable_type
    add_index :redde_photos, :token
  end
end
