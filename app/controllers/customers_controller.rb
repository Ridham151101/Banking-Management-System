class CustomersController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @user = User.new
    @customer = Customer.new
  end

  def create
    @user = User.new(user_params)
    @customer = Customer.new(customer_params)
    @user.add_role(:customer)
  
    if @user.save!
      @customer.user_id = @user.id
      if @customer.save!
        @account_request = AccountRequest.create(customer_id: @customer.id, user_id: @user.id, status: 'pending')
        if @account_request.save!
          AccountRequestMailer.account_request_approval(@account_request).deliver_now
          
          flash[:success] = 'Your account creation request has been submitted successfully'
          redirect_to new_user_session_path
        end
      end
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def customer_params
    params.require(:user).require(:customer).permit(:phone, :address, :birthdate, :gender)
  end
end
