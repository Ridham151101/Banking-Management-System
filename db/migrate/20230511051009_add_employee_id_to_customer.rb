class AddEmployeeIdToCustomer < ActiveRecord::Migration[6.1]
  def change
    add_column :customers, :employee_id, :integer
  end
end
