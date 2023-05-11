class CustomersController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @customers = Customer.joins(:account_request)
    # @pending_customers = @customers.where(account_requests: { status: 'pending' })
    # @approved_customers = @customers.where(account_requests: { status: 'approved' })
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
      redirect_to new_user_session_path
    else
      render :new
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, customer_attributes: [:phone, :address, :birthdate, :gender, :employee_id])
  end  
end
