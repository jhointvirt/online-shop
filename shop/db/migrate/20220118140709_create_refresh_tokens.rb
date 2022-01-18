class CreateRefreshTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :refresh_tokens do |t|
      t.string :refresh_token, null: false
      t.datetime :expiry_time, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
