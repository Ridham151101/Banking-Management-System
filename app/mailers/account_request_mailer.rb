class AccountRequestMailer < ApplicationMailer
  def account_request_approval(account_request)
    @account_request = account_request

    mail(to: @account_request.user.email, subject: 'New account request')
  end

  def account_created(account_request, account)
    @account_request = account_request
    @account = account
    mail(to: @account_request.customer.user.email, subject: 'Your account has been created')
  end
end
