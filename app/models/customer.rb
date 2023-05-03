class Customer < ApplicationRecord
  belongs_to :users
  has_one :account_request
end
