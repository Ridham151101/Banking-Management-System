class EmployeeTransaction < ApplicationRecord
  belongs_to :user
  belongs_to :transaction_record, class_name: 'Transaction', optional: true
end
