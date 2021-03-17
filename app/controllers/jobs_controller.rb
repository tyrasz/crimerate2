class JobsController < ApplicationController
  # before_action :find_job, only: [:show]

  def index
    @jobs = policy_scope(Job)
    @markers = @jobs.geocoded.map do |job|
      {
        lng: job.longitude,
        lat: job.latitude
      }
    end
  end

  def new
    @service = Service.find(params[:service_id])
    @job = Job.new
    @job.user = current_user
    authorize @job
  end

  def show
    @job = find_job
    authorize @job
  end

  def create
    @job = Job.new(job_params)
    @service = Service.find(params[:service_id])
    @job.user = current_user
    @job.service = @service
    @job.status = "Not yet started"
    authorize @job
    if @job.save!
      order = Order.create!(job: @job, service_sku: @job.service.name, amount: @job.service.price, state: 'pending', user: current_user)

      session = Stripe::Checkout::Session.create(
        payment_method_types: ['card'],
        line_items: [{
          name: @job.service.name,
          amount: @job.service.price_cents,
          currency: 'usd',
          quantity: 1
        }],
        success_url: order_url(order),
        cancel_url: order_url(order)
      )

      order.update(checkout_session_id: session.id)
      redirect_to new_order_payment_path(order), alert: "Your job has been created!"
    else
      render :new
    end
  end

  def destroy
    @job = find_job
    authorize @job
    @job.destroy

    redirect_to jobs_path
  end

  def nearby
    @jobs = policy_scope(Job) && Job.where(status: "Completed")
    @markers = @jobs.geocoded.map do |job|
    {
        lng: job.longitude,
        lat: job.latitude,
        infoWindow: { content: render_to_string(partial: "info_window", locals: { job: job }) }
    }
    end
    authorize @jobs
  end

  private

  def find_job
    @job = Job.find(params[:id])
  end

  def job_params
    params.require(:job).permit(:description, :date, :location, :service_id, :user_id)
  end
end
