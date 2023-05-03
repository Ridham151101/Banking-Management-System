class UserMailer < ApplicationMailer
  def new_employee_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to the Bank!')
  end
end
