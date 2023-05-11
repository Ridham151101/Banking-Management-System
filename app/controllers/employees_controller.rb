class EmployeesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_user, except: [:index, :new, :create]

  def index
    @employees = User.employee
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.add_role(:employee)

    if @user.save
      UserMailer.new_employee_email(@user).deliver_now
      redirect_to employees_path, notice: 'Employee user created successfully.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to employees_path, notice: "Employee was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @user.destroy!
    redirect_to employees_path, notice: "Employee successfully destroyed."
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
