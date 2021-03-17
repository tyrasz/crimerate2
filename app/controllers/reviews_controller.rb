class ReviewsController < ApplicationController
  def index
    @reviews = policy_scope(Review)
    if params[:job_id]
      @reviews = Review.where(:job_id => params[:job_id])
    else
      @reviews = Review.all
    end
  end

  def show
    @review = Review.find(review_params)
    authorize @review
  end

  def new
    @review = Review.new
    @job = Job.find(params[:job_id])
    @review.job = @job
    @user = User.new

    authorize @review
  end

  def create
    @review = Review.new(review_params)
    @job = Job.find(params[:job_id])
    @review.job = @job
    @review.user = current_user
    authorize @review
    if @review.save!
      redirect_to job_reviews_path(@job)
    else
      render :new
    end
  end

  def edit
    @review = Review.find(params[:id])
    authorize @review
  end

  def update
    @review = Review.new(review_params)
    @review.user = current_user
    authorize @review
    if @review.update(review_params)
      redirect_to reviews_path(@review)
    else
      render :edit
    end
  end

  def destroy
    @review = Review.find(params[:id])
    authorize @review
    @review.destroy
    redirect_to reviews_path
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end
