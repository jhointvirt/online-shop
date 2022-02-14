class RenameItemsToProducts < ActiveRecord::Migration[7.0]
  def change
    rename_table :items, :products
    rename_column :reviews, :item_id, :product_id
  end
end
