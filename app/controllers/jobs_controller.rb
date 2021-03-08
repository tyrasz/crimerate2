class JobsController < ApplicationController
  before_action :find_job, only: [:show]

  def index
    @jobs = policy_scope(Job)
    authorize(@jobs)
    verify_authorized
  end

  def show
    @job = Job.find(params[:id])
    authorize @job
  end

  def new
    @job = Job.new
    @user = User.new

    authorize @job
  end

  def create
    @job = Job.new(job_params)
    @job.user = current_user
    authorize @job

    if @job.save
      redirect_to @job
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
    params.require(:job).permit(:description, :date, :location, :service)
  end
end
