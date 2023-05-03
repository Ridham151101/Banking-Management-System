class AccountRequestMailer < ApplicationMailer
  def account_request_approval(account_request)
    @account_request = account_request
    @url = approve_account_request_url(account_request)

    mail(to: User.with_role(:employee).pluck(:email), subject: 'New account request')
  end
end
