class Customer < ApplicationRecord
  belongs_to :user, optional: true
  has_one :account_request, dependent: :destroy
  has_one :account
  has_many :transaction_logs
  has_many :favorite_recipients, dependent: :destroy

  validates :phone, presence: true, format: { with: /\A\d{10}\z/, message: "should be a 10-digit number" }
  validates :address, presence: true
  validate :birthdate_cannot_be_future_date
  validates :gender, presence: true

  after_create :create_account_request

  private

  def birthdate_cannot_be_future_date
    if birthdate.present? && birthdate.future?
      errors.add(:birthdate, "cannot be a future date")
    end
  end

  def create_account_request
    @account_request = AccountRequest.create(customer_id: self.id, user_id: self.employee_id, status: 'pending')
    if @account_request.save!
      AccountRequestMailer.account_request_approval(@account_request).deliver_now
    end
  end
end
