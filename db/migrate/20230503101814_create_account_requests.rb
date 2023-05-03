class CreateAccountRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :account_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
