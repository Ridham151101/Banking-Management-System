class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.decimal :amount
      t.string :description
      t.integer :transaction_type
      t.decimal :starting_balance
      t.decimal :ending_balance
      t.string :recipient_account_number
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
