class OrdersController < ApplicationController
  def create
    job = Job.find(params[:job_id])
    order = Order.create!(job: service, service_sku: job.service.name, amount: job.service.price, state: 'pending', user: current_user)
    skip_authorization

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        name: job.service.name,
        amount: job.service.price_cents,
        currency: 'usd',
        quantity: 1
      }],
      success_url: order_url(order),
      cancel_url: order_url(order)
    )

    order.update(checkout_session_id: session.id)
    redirect_to new_order_payment_path(order)
  end

  def show
    mail = OrderMailer.with(user: current_user, order: @order).order
    mail.deliver_now
    @order = current_user.orders.find(params[:id])
    @user = current_user
    authorize @order
  end
end
