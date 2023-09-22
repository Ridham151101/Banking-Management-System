class Transaction < ApplicationRecord
  belongs_to :account
  has_many :transaction_logs
  has_one :employee_transaction

  enum transaction_type: [:deposit, :withdrawal, :transfer]
end
