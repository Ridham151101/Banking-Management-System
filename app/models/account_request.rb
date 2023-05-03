class AccountRequest < ApplicationRecord
  belongs_to :users
  belongs_to :customers
end
