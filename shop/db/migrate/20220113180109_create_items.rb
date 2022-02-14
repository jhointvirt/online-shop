class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.decimal :price, null: false
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
