class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def vendors_show
    @vendor = User.where(role: 'vendor') && User.find(params[:id])
  end

  def home
    if current_user
      @banner = true
      # render :home --> this now routes to _banner partial
    else
      @splash = true
      # render :splash --> this now routes to _splash partial
    end
  end

  def search
    if params[:search].blank?
      redirect_to(root_path, alert: "Empty field!") and return
    else
      @parameter = params[:search].downcase
      @results = Service.all.where("lower(category) ILIKE :search", search: "%#{@parameter}%")
    end
  end

  def vendors
    # @vendors = User.where(role: 'vendor')

    if params[:search].present?
      @vendors = User.where(["location ILIKE ?", "%#{params[:search]}%"])
    else
      @vendors = User.where(role: 'vendor')
    end
  end
end
