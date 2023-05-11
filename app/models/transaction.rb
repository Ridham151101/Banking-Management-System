class Transaction < ApplicationRecord
  belongs_to :account
  has_many :transaction_logs

  enum transaction_type: [:deposit, :withdrawal, :transfer]
end
