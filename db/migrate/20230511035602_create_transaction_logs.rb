class CreateTransactionLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :transaction_logs do |t|
      t.decimal :transaction_amount
      t.decimal :starting_balance
      t.decimal :ending_balance
      t.integer :transaction_type
      t.references :customer, null: false, foreign_key: true
      t.references :transaction, null: false, foreign_key: true

      t.timestamps
    end
  end
end
