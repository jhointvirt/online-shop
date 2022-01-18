class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.text :description
      t.references :item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
