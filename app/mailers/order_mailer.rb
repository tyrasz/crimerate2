class OrderMailer < ApplicationMailer
  def order
    @user = params[:user]# Instance variable => available in view
    @order = params[:order]
    mail(to: @user.email, subject: 'Thanks for your order from CrimeRate')
  end
end
