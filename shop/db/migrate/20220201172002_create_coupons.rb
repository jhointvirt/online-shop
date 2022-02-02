class CreateCoupons < ActiveRecord::Migration[7.0]
  def change
    create_table :coupons do |t|
      t.string :code, null: false
      t.integer :discount, null: false
      t.integer :used_count, null: false

      t.timestamps
    end
  end
end
