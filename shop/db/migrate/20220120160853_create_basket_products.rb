class CreateBasketProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :basket_products do |t|
      t.belongs_to :basket, :product, :null    => false
      t.timestamps
    end
  end
end
