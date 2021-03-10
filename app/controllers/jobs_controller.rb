class JobsController < ApplicationController
  # before_action :find_job, only: [:show]

  def index
    @jobs = policy_scope(Job)
    authorize(@jobs)
    verify_authorized
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
    @job = Job.find(params[:id])
    authorize @job
  end

  def create
    @job = Job.new(job_params)
    @service = Service.find(params[:service_id])
    @job.user = current_user
    @job.service = @service
    authorize @job
    if @job.save
      redirect_to jobs_path
    else
      render :new
    end
  end

  def destroy
    @job = Job.find(params[:id])
    authorize @job
    @job.destroy

    redirect_to jobs_path
  end

  private


  def find_job
    @job = Job.find(params[:id])
  end


  def job_params
    params.require(:job).permit(:description, :date, :location, :service_id, :user_id)
  end
end
