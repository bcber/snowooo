class SnowbindingsController < ApplicationController
  before_action :set_snowbinding, only: [:show, :edit, :update, :destroy]
  respond_to :html

  def index
    brands = params[:brands] || []
    snowbindings = Snowbinding.all
    snowbindings = snowbindings.in(brand: brands) if brands.any?
    @snowbindings = snowbindings.paginate(:page => params[:page], :per_page => 16)
  end

  def show
    session[:reply_page] = url_for(@snowbinding)
    set_seo_meta("#{@snowbinding.title}", "#{@snowbinding.title}")
  end

  private
    def set_snowbinding
      @snowbinding = Snowbinding.find(params[:id])
    end

    def snowbinding_params
      params[:snowbinding]
    end
end
