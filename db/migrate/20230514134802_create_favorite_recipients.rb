class CreateFavoriteRecipients < ActiveRecord::Migration[6.1]
  def change
    create_table :favorite_recipients do |t|
      t.references :customer, null: false, foreign_key: true
      t.string :recipient_name
      t.string :account_number

      t.timestamps
    end
  end
end
