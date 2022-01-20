class CreateBaskets < ActiveRecord::Migration[7.0]
  def change
    create_table :baskets do |t|
      t.integer :discount, default: 0, null: false
      t.integer :product_quantity, default: 0, null: false
      t.decimal :total_price, default: 0, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
