class CreateCustomers < ActiveRecord::Migration[6.1]
  def change
    create_table :customers do |t|
      t.string :phone
      t.string :address
      t.date :birthdate
      t.string :gender
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
