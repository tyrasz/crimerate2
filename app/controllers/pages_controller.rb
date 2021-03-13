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
      @results = Service.global_search(params[:search])
    end
  end

  def vendors
    # @vendors = User.where(role: 'vendor')

    if params[:search].present?
      @vendors = User.search_by_location_and_handle(params[:search])
    else
      @vendors = User.where(role: 'vendor')
    end
    # @vendors = policy_scope(@vendors)
  end
end
