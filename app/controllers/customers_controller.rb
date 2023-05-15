class CustomersController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @customers = Customer.all
    if params[:status].present?
      @customers = Customer.joins(:account_request).where(account_request: { status: params[:status] })
    elsif params[:account_number].present?
      @customers = Customer.joins(:account).where(accounts: { account_number: params[:account_number] }) if params[:account_number].present?
    end
  end

  def new
    @employees = User.employee
    @user = User.new
    @user.build_customer
  end

  def create
  @user = User.new(user_params)
  @user.add_role(:customer)
  
  if @user.save!
    flash[:success] = 'Your account creation request has been submitted successfully'
    if current_user&.admin?
      redirect_to customers_path
    else
      redirect_to new_user_session_path
    end
  else
    render :new
  end
end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, customer_attributes: [:phone, :address, :birthdate, :gender, :employee_id])
  end  
end
