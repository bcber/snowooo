class SnowbindingsController < ApplicationController
  before_action :set_snowbinding, only: [:show, :edit, :update, :destroy]
  respond_to :html

  def index
    brands = params[:brands] || []
    colors = params[:colors] || []
    materials = params[:materials] || []
    flexs = params[:flexs] || []
    mounts = params[:mounts] || []

    snowbindings = Snowbinding.all
    snowbindings = snowbindings.in(brand: brands) if brands.any?
    snowbindings = snowbindings.in(colors: colors) if colors.any?
    snowbindings = snowbindings.in(material: materials.map{|f| /#{f}/}) if materials.any?
    snowbindings = snowbindings.in(flex: flexs.map{|f| /#{f}/}) if flexs.any?
    snowbindings = snowbindings.in(mount: mounts.map{|f| /#{f}/}) if mounts.any?

    @snowbindings = snowbindings.paginate(:page => params[:page], :per_page => 16)
  end

  def show
    session[:reply_page] = url_for(@snowbinding)
    @snowbinding.view
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
