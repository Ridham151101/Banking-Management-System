class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home]

  def home
    return unless user_signed_in?

    if current_user.admin? || current_user.employee?
      display_charts_for_admin_and_employee
    else
      display_account_details_and_transactions_for_customer
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
    approve_account(customer)
  end

  private

  def display_charts_for_admin_and_employee
    @employees = User.employee
    @customers = User.customer
    @customer_gender_data = Customer.group(:gender).count
  end

  def display_account_details_and_transactions_for_customer
    @customer = current_user.customer
    @account = @customer.account
    @transactions = @account.transactions.last(10)
  end

  def approve_account(customer)
    account_request = customer.customer.account_request
    account_request.status = 'approved'
    @account = Account.new(account_params)
    @account.customer_id = account_request.customer_id

    if account_request.save && @account.save
      AccountRequestMailer.account_created(account_request, @account).deliver_now
      redirect_path = current_user&.admin? ? customers_path : root_path
      redirect_to redirect_path, notice: 'Account created and request approved'
    else
      render :new_account
    end
  end

  def account_params
    params.require(:account).permit(:account_number, :account_type, :balance)
  end
end
