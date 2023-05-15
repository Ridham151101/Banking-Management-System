class FavoriteRecipientsController < ApplicationController
  def index
    @favorite_recipients = current_user.customer.favorite_recipients
  end
  
  def new
    @favorite_recipient = current_user.customer.favorite_recipients.build
  end
  
  def create
    @favorite_recipient = current_user.customer.favorite_recipients.build(favorite_recipient_params)

    if @favorite_recipient.save
      flash[:notice] = "Favorite recipient added successfully."
    else
      flash[:alert] = "Failed to add favorite recipient."
    end

    redirect_to new_transaction_path
  end

  def destroy
    @favorite_recipient = current_user.customer.favorite_recipients.find(params[:id])
    @favorite_recipient.destroy

    flash[:notice] = "Favorite recipient removed successfully."
    redirect_to new_transaction_path
  end

  private

  def favorite_recipient_params
    params.require(:favorite_recipient).permit(:recipient_name, :account_number)
  end
end
