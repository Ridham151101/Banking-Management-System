class Customer < ApplicationRecord
  belongs_to :user, optional: true
  has_one :account_request, dependent: :destroy
  has_many :accounts

  after_create :create_account_request

  private

  def create_account_request
    @account_request = AccountRequest.create(customer_id: self.id, user_id: self.user_id, status: 'pending')
    if @account_request.save!
      AccountRequestMailer.account_request_approval(@account_request).deliver_now
    end
  end
end
