class Admin::SnowboardsController < Admin::ApplicationController
  before_action :set_snowboard, only:[:edit,:update,:destroy, :set_top,:cancel_top, :set_recommend,:cancel_recommend]
  def index
    if params[:order]
      @snowboards = Snowboard.desc(params[:order])
    else
      @snowboards = Snowboard.recent
    end
    @snowboards = @snowboards.paginate(:page => params[:page], :per_page => 10)
  end

  def new
    @snowboard = Snowboard.new
    3.times{ @snowboard.qiniu_images.build }
  end

  def edit
    @snowboard.qiniu_images.build
  end

  # up
  def set_top
    @snowboard.set_top
    redirect_to admin_snowboards_path, notice:"设置成功"
  end

  def cancel_top
    @snowboard.cancel_top
    redirect_to admin_snowboards_path, notice:"设置成功"
  end

  #recommend
  def recommend
    if @snowboard.update(recommend_at: Time.now)
      redirect_to admin_snowboards_path
    end
  end

  def cancel_recommend
    @snowboard.cancel_recommend
    redirect_to admin_snowboards_path, notice:"设置成功"
  end

  def create
    @snowboard = Snowboard.new(snowboard_params)

    respond_to do |format|
      if @snowboard.save
        format.html { redirect_to admin_snowboards_path, notice: '创建成功.' }
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
        format.html { redirect_to edit_admin_snowboard_path(@snowboard), notice: '成功编辑.' }
        format.json { render :show, status: :ok, location: @snowboard }
      else
        format.html { render :edit }
        format.json { render json: @snowboard.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @snowboard.destroy
    respond_to do |format|
      format.html { redirect_to admin_snowboards_path, notice: '成功删除.' }
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
    permitted = params[:snowboard].permit(:name, :brand, :length, :profile, :shape, :style, :flex, :effectiveedge, :waistwidth,
                              :sidecutradius, :stancesetback,
                              :stancewidth,:mount, :core, :wrap,
                              :sidewalls, :edge,:color_list,
                              :base, :recommendedriderweight,
                              :recommendeduse, :manufacturerwarranty,
                              :description, :origurl,
                              {
                                  qiniu_images_attributes: [:id,:colors,:original, :remote_original_url, :_destroy]
                              }
    )
  end
end