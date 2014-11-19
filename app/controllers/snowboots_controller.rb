class SnowbootsController < ApplicationController
  before_action :set_snowboot, only: [:show, :edit, :update, :destroy]
  respond_to :html
  load_and_authorize_resource

  def index
    styles = params[:styles] || []
    brands = params[:brands] || []
    snowboots = Snowboot.all

    snowboots = snowboots.in(style: styles) if styles.any?
    snowboots = snowboots.in(brand: brands) if brands.any?

    @snowboots = snowboots.paginate(page: params[:page], per_page: 16)
  end

  def show
    session[:reply_page] = url_for(@snowboot)
    set_seo_meta("#{@snowboot.title}", "#{@snowboot.title}")
  end

  def new
    @snowboot = Snowboot.new
    respond_with(@snowboot)
  end

  def edit
  end

  def create
    @snowboot = Snowboot.new(snowboot_params)
    @snowboot.save
    respond_with(@snowboot)
  end

  def update
    @snowboot.update(snowboot_params)
    respond_with(@snowboot)
  end

  def destroy
    @snowboot.destroy
    respond_with(@snowboot)
  end

  private
    def set_snowboot
      @snowboot = Snowboot.find(params[:id])
    end

    def snowboot_params
      params[:snowboot]
    end
end
