class HomeController < ApplicationController
  def index
    @employees = User.with_role(:employee)
    @customers = User.with_role(:customer).includes(:account_request)
    @pending_customers = @customers.select { |c| c.account_request&.status == 'pending' }
    @approved_customers = @customers.select { |c| c.account_request&.status == 'approved' }
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
