class TransactionLog < ApplicationRecord
  belongs_to :customer
  belongs_to :related_transaction, class_name: "Transaction", foreign_key: "transaction_id"

  enum transaction_type: [:deposit, :withdrawal, :transfer]
end
