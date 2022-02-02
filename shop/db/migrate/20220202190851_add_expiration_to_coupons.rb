class AddExpirationToCoupons < ActiveRecord::Migration[7.0]
  def change
    add_column :coupons, :expiration_date, :datetime
  end
end
