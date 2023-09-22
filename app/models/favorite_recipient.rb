class FavoriteRecipient < ApplicationRecord
  belongs_to :customer

  validates :recipient_name, presence: true
  validate :validate_account_number

  private

  def validate_account_number
    account = Account.find_by(account_number: account_number)
    errors.add(:account_number, 'does not exist') unless account
  end
end
