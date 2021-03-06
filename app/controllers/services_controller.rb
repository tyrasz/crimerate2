class ServicesController < ApplicationController
  def index
    @services = policy_scope(Service)
    if params[:search].present?
      @services = Service.where(["category ILIKE ?", "%#{params[:search]}%"])
    else
      @services = Service.all
    end
  end

  def show
    @service = Service.find(params[:id])
    authorize @service
  end

  def new
    @service = Service.new
    @user = User.new

    authorize @service ## add after youve found the service
  end

  def create
    @service = Service.new(service_params)
    @service.user = current_user
    authorize @service
    if @service.save
      redirect_to services_path, alert: "Created new service!"
    else
      render :new
    end
  end

  def edit
    @service = Service.find(params[:id])
    authorize @service
  end

  def update
    @service = Service.find(params[:id])
    @service.user = current_user
    authorize @service
    if @service.update(service_params)
      redirect_to service_path(@service)
    else
      render :edit
    end
  end

  def destroy
    @service = Service.find(params[:id])
    authorize @service
    @service.destroy
    redirect_to services_path
  end

  def byvendors
    @vendor = User.find(params[:id])
    @services = @vendor.services
    skip_authorization
  end

  def top
    services = Service.all.select do |service|
      service.have_ratings?
    end

    skip_authorization

    ratings = services.map do |service|
      service.avg_ratings
    end

    service_ratings = Hash[services.zip(ratings)].sort_by(&:last).reverse!
    top = service_ratings.map do |service|
      service[0] if service[1] == 5
    end
    @top = top.compact
  end

  private

  def service_params
    params.require(:service).permit(:name, :price, :category, :user_id, :photo)
  end
end
