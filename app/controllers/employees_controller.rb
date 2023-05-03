class EmployeesController < ApplicationController
  before_action :authenticate_admin!

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.add_role(:employee)

    if @user.save
      UserMailer.new_employee_email(@user).deliver_now
      redirect_to root_path, notice: 'Employee user created successfully.'
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
