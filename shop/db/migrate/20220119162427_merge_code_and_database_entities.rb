class MergeCodeAndDatabaseEntities < ActiveRecord::Migration[7.0]
  def change
    change_column :categories, :title, :string, null: false

    change_column :reviews, :rating, :integer, null: false
    change_column :reviews, :description, :text, null: false

    change_column :users, :email, :string, null: false
    change_column :users, :username, :string, null: false
    change_column :users, :password_digest, :string, null: false
  end
end
