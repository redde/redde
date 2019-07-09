class CreateArticleCategories < ActiveRecord::Migration[4.2]
  def change
    create_table :article_categories do |t|
      t.string :title
      t.integer :position
      t.boolean :visible

      t.timestamps null: false
    end
  end
end
