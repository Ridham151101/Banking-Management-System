class TransactionsController < ApplicationController
  before_action :set_employee_transaction, only: [:new, :create]
  before_action :set_account, only: [:new, :create]

  def index
    @transaction_logs = current_user.customer.transaction_logs.order(created_at: :desc)
  end

  def new
    @transaction_types = Transaction.transaction_types
    @transaction = @account.transactions.build
  end
  
  def create
    @transaction = @account.transactions.build(transaction_params)
    @transaction.starting_balance = @account.balance.nil? ? 0 : @account.balance

    case @transaction.transaction_type
    when 'deposit'      
      @transaction.ending_balance = @transaction.starting_balance + @transaction.amount
    when 'withdrawal'
      if @transaction.starting_balance < @transaction.amount
        flash[:alert] = "Insufficient balance"
        redirect_to new_transaction_path && return
      else
        withdraw_money
      end
    when 'transfer'
      
      recipient_account = Account.find_by(account_number: params[:transaction][:recipient_account_number])
      if recipient_account.nil?
        flash[:alert] = "Recipient account not found"
        redirect_to new_transaction_path
        return
      end
      
      if @transaction.starting_balance < @transaction.amount
        flash[:alert] = "Insufficient balance"
        redirect_to new_transaction_path && return
      else
        withdraw_money
      end

      ActiveRecord::Base.transaction do
        @transaction.save!
        create_transaction_log(@transaction)
        recipient_transaction = recipient_account.transactions.create!(
          amount: @transaction.amount,
          description: @transaction.description,
          transaction_type: 'deposit',
          starting_balance: recipient_account.balance,
          ending_balance: (recipient_account.balance || 0) + @transaction.amount
        )
        create_transaction_log(recipient_transaction)

        update_account_balance(@account, @transaction)
        update_account_balance(recipient_account, recipient_transaction)
        update_employee_transaction_id(@employee_transaction, @transaction)
      end

      flash[:notice] = "Transfer successful"
      redirect_to root_path
      return
    end

    if @transaction.save
      create_transaction_log(@transaction)
      update_account_balance(@account, @transaction)
      update_employee_transaction_id(@employee_transaction, @transaction)
      flash[:notice] = "Transaction successful"
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def update_account_balance(account, transaction)
    account.update!(balance: (transaction.ending_balance || 0))
  end

  def update_employee_transaction_id(employee_transaction, transaction)
    employee_transaction.update!(transaction_id: (transaction.id))
  end

  def withdraw_money 
    @transaction.ending_balance = @transaction.starting_balance - @transaction.amount
  end

  def set_employee_transaction
    @employee_transaction = EmployeeTransaction.last
  end
  
  def set_account
    if current_user.employee?
      @account = Account.find_by(account_number: @employee_transaction.customer_account_number)
    else
      @account = current_user.customer.account
    end
  end

  def create_transaction_log(transaction)
    TransactionLog.create!(related_transaction: transaction, transaction_amount: transaction.amount, starting_balance: transaction.starting_balance, ending_balance: transaction.ending_balance, transaction_type: transaction.transaction_type, customer_id: transaction.account.customer.id, transaction_id: transaction.id)
  end

  def transaction_params
    params.require(:transaction).permit(:amount, :description, :transaction_type, :recipient_account_number)
  end
end
