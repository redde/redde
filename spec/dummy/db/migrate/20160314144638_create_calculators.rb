class CreateCalculators < ActiveRecord::Migration[4.2]
  def change
    create_table :calculators do |t|
      t.string :name
      t.integer :position

      t.timestamps null: false
    end
  end
end
