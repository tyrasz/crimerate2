class ReviewsController < ApplicationController
  def index
    @reviews = policy_scope(Review)
  end

  def show
    @review = Review.find(review_params)
    authorize @review
  end

  def new
    @review = Review.new
    @user = User.new

    authorize @review ## add after youve found the review
  end

  def create
    @review = Review.new(review_params)
    @review.user = current_user
    authorize @review
    if @review.save
      redirect_to reviews_path
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