class AddColumnAncestryToArticleCategories < ActiveRecord::Migration
  def change
    add_column :article_categories, :ancestry, :string
  end
end
