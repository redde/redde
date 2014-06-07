class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :imageable_id
      t.string :imageable_type
      t.integer :position
      t.string :src
      t.string :token

      t.timestamps
    end
    add_index :photos, :imageable_id
    add_index :photos, :imageable_type
    add_index :photos, :token
  end
end
