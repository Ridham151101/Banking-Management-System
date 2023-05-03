class HomeController < ApplicationController
  def index
    @employees = User.employee
    @customers = User.customer.joins(:account_request)
    @pending_customers = @customers.where(account_requests: { status: 'pending' })
    @approved_customers = @customers.where(account_requests: { status: 'approved' })
  end  

  def approve_account_request
    customer = User.find(params[:id])
    account_request = customer.account_request
    account_request.status = 'approved'
    if account_request.save
      flash[:success] = 'Account request approved successfully!'
    else
      flash[:error] = 'Something went wrong. Please try again.'
    end
    redirect_to root_path
  end  
end
