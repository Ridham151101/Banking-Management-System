class HomeController < ApplicationController
  def index
    @employees = User.employee
    @customers = User.customer.joins(:account_request)
    @pending_customers = @customers.where(account_requests: { status: 'pending' })
    @approved_customers = @customers.where(account_requests: { status: 'approved' })
  end 
  
  def new_account
    @account = Account.new
    @customer = User.find(params[:customer_id])
  end

  def approve_account_request
    customer = User.find(params[:id])
    account_request = customer.account_request
    account_request.status = 'approved'
    @account = Account.new(account_params)
    @account.customer_id = account_request.customer_id

    if account_request.save && @account.save
      AccountRequestMailer.account_created(account_request, @account).deliver_now
      redirect_to root_path, notice: 'Account created and request approved'
    else
      render :new_account
    end
  end

  private
  
  def account_params
    params.require(:account).permit(:account_number, :account_type, :balance)
  end 
end
