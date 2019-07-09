class CreateArticles < ActiveRecord::Migration[4.2]
  def change
    create_table :articles do |t|
      t.string :title
      t.datetime :published_at
      t.text :body
      t.string :comment
      t.timestamps null: false
    end
  end
end
