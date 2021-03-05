class ServicesController < ApplicationController
  def index
    @services = Service.all
  end

  def show
    @service = Service.find(params[:id])
  end

  def new
    @service = Service.new
    @user = User.new
  end

  def create
    @user = User.find(params[:user_id])
    @service = Service.new(service_params)
    @service.user = @user
    if @service.save
      redirect_to services_path
    else
      render :new
    end
  end

  def edit
    @service = Service.find(params[:id])
    @user = User.new
  end

  def update
    @user = User.find(params[:user_id])
    @service = Service.new(service_params)
    @service.user = @user
    if @service.update(service_params)
      redirect_to service_path(@service)
    else
      render :edit
    end
  end

  def destroy
    @service = Service.find(params[:id])
    @service.destroy
    redirect_to services_path
  end

  private

  def service_params
    params.require(:service).permit(:name, :price, :category, :user_id)
  end
end
