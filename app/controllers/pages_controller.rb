class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    if current_user
      render :home
    else
      render :splash
    end
  end

  def search
    if params[:search].blank?
      redirect_to(root_path, alert: "Empty field!") and return
    else
      @parameter = params[:search].downcase
      @results = Service.all.where("lower(category) LIKE :search", search: "%#{@parameter}%")
    end
  end

  def vendors
    @vendors = User.where(role: "vendor")
  end

  def users
    @users = User.where(role: "user")
  end
end
