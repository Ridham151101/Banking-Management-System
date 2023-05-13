class CreateEmployeeTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :employee_transactions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :transaction, foreign_key: true
      t.string :customer_account_number

      t.timestamps
    end
  end
end
