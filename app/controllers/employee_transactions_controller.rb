class EmployeeTransactionsController < ApplicationController
  def new
    @employee_transaction = EmployeeTransaction.new
  end

  def create
    @employee_transaction = EmployeeTransaction.new(employee_transaction_params)
    if @employee_transaction.save!
      redirect_to new_transaction_path, notice: 'Employee transaction was successfully created.'
    else
      render :new
    end
  end

  private

  def employee_transaction_params
    params.require(:employee_transaction).permit(:customer_account_number).merge(user_id: current_user.id)
  end
end
