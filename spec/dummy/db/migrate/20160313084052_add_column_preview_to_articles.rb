class AddColumnPreviewToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :preview, :string
  end
end
