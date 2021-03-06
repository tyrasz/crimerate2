class JobsController < ApplicationController
  before_action :find_job, only: [:show]

  def index
    @jobs = Job.all
  end

  def show
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
    if @job.save
      redirect_to @job
    else
      render :new
    end
  end

  def destroy
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
