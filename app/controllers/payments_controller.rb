class PaymentsController < ApplicationController
  def new
    @order = current_user.orders.find_by(state: 'pending', id: params[:order_id])
    skip_authorization
  end
end
