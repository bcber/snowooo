class SnowboardsController < ApplicationController
  before_action :set_snowboard, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  respond_to :html
  # GET /snowboards
  # GET /snowboards.json
  def index
    styles = params[:styles] || []
    brands = params[:brands] || []
    colors = params[:colors] || []
    shapes = params[:shapes] || []
    flexs = params[:flexs] || []
    snowboards = Snowboard.all

    snowboards = snowboards.in(style: styles) if styles.any?
    snowboards = snowboards.in(brand: brands) if brands.any?
    snowboards = snowboards.in(colors: colors) if colors.any?
    snowboards = snowboards.in(shape: shapes.map{|f| /#{f}/}) if shapes.any?
    snowboards = snowboards.in(flex: flexs.map{|f| /#{f}/ }) if flexs.any?

    @snowboards = snowboards.paginate(:page => params[:page], :per_page => 16)
  end

  # GET /snowboards/1
  # GET /snowboards/1.json
  def show
    session[:reply_page] = url_for(@snowboard)
    @snowboard.view
    set_seo_meta("#{@snowboard.title}", "#{@snowboard.title}")
  end

  # GET /snowboards/new
  def new
    @snowboard = Snowboard.new
  end

  # GET /snowboards/1/edit
  def edit
    @snowboard.images.build
  end

  # POST /snowboards
  # POST /snowboards.json
  def create
    @snowboard = Snowboard.new(snowboard_params)

    respond_to do |format|
      if @snowboard.save
        format.html { redirect_to @snowboard, notice: 'Snowboard was successfully created.' }
        format.json { render :show, status: :created, location: @snowboard }
      else
        format.html { render :new }
        format.json { render json: @snowboard.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /snowboards/1
  # PATCH/PUT /snowboards/1.json
  def update
    respond_to do |format|
      if @snowboard.update(snowboard_params)
        format.html { redirect_to @snowboard, notice: 'Snowboard was successfully updated.' }
        format.json { render :show, status: :ok, location: @snowboard }
      else
        format.html { render :edit }
        format.json { render json: @snowboard.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /snowboards/1
  # DELETE /snowboards/1.json
  def destroy
    @snowboard.destroy
    respond_to do |format|
      format.html { redirect_to snowboards_url, notice: 'Snowboard was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_snowboard
      @snowboard = Snowboard.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def snowboard_params
      params.require(:snowboard).permit(
        {
          images_attributes: [:id, :_destroy,:colors, :small, :medium, :large]
        },
        :name, 
        :brand,
        :profile,
        :shape,
        :style,
        :flex,
        :effectiveedge,
        :waistwidth,
        :sidecutradius,
        :stancewidth,
        :stancesetback,
        :mount,
        :core,
        :wrap,
        :sidewalls,
        :edge,
        :base,
        :recommendedriderweight,
        :recommendeduse,
        :manufacturerwarranty,
        :description,
        :length)
    end
end
