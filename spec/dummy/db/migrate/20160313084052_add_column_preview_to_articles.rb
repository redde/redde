class AddColumnPreviewToArticles < ActiveRecord::Migration[4.2]
  def change
    add_column :articles, :preview, :string
  end
end
