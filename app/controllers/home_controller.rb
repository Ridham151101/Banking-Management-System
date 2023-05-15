class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    if user_signed_in?
      if current_user.admin? || current_user.employee?
        # Logic for displaying charts for admin and employee
        @employees = User.employee
        @customers = User.customer
        @customer_gender_data = Customer.group(:gender).count
      else
        # Logic for displaying account details and transactions for customer
        @customer = current_user.customer
        @account = @customer.account
        @transactions = @account.transactions.last(10)
      end
    else
    end
  end

  def account_details
    @customer = Customer.find(params[:customer_id])
    @account = @customer.account
  end
  
  def new_account
    @account = Account.new
    @customer = User.find(params[:customer_id])
  end

  def approve_account_request
    customer = User.find(params[:id])
    account_request = customer.customer.account_request
    account_request.status = 'approved'
    @account = Account.new(account_params)
    @account.customer_id = account_request.customer_id

    if account_request.save && @account.save
      AccountRequestMailer.account_created(account_request, @account).deliver_now
      if current_user&.admin?
        redirect_to customers_path, notice: 'Account created and request approved'
      else
        redirect_to root_path, notice: 'Account created and request approved'
      end
    else
      render :new_account
    end
  end

  private
  
  def account_params
    params.require(:account).permit(:account_number, :account_type, :balance)
  end 
end
