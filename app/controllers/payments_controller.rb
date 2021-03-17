class PaymentsController < ApplicationController
  def new
    @order = current_user.orders.find_by(state: 'pending', id: params[:order_id])
    # mail = OrderMailer.with(user: current_user).order
    # mail.deliver_now
    mail = OrderMailer.with(user: current_user, order: @order).order
    mail.deliver_now
    skip_authorization
  end
end
