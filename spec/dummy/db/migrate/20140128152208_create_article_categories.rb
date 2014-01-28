class CreateArticleCategories < ActiveRecord::Migration
  def change
    create_table :article_categories do |t|
      t.string :title
      t.boolean :visible
      t.integer :position

      t.timestamps
    end
  end
end
