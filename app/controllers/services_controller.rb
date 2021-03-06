class ServicesController < ApplicationController
  def index
    @services = policy_scope(Service)
  end

  def show
    @service = Service.find(params[:id])
    authorize @service
  end

  def new
    if current_user.role == 'vendor'
      @service = Service.new
      @user = User.new
    else
      puts 'you are not authorized'
    end

    authorize @service ## add after youve found the service
  end

  def create
    @user = current_user
    @service = Service.new(service_params)
    authorize @service
    @service.user = @user
    if @service.save
      redirect_to services_path
    else
      render :new
    end
  end

  def edit
    @service = Service.find(params[:id])
    authorize @service
  end

  def update
    @user = User.find(params[:user_id])
    @service = Service.new(service_params)
    authorize @service
    @service.user = @user
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

  private

  def service_params
    params.require(:service).permit(:name, :price, :category, :user_id)
  end
end
