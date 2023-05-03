class Customer < ApplicationRecord
  belongs_to :user, optional: true
  has_one :account_request
end
