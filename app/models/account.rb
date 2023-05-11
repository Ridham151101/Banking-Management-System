class Account < ApplicationRecord
  ACCOUNT_NUMBER_LENGTH = 14
  belongs_to :customer
  before_create :generate_account_number
  validates :account_number, uniqueness: true

  private

  def generate_account_number
    loop do
      self.account_number = SecureRandom.random_number(10**ACCOUNT_NUMBER_LENGTH).to_s.rjust(ACCOUNT_NUMBER_LENGTH, '0')
      break unless Account.exists?(account_number: account_number)
    end
  end
end

