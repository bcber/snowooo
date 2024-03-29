class Admin::SnowbootsController < Admin::ApplicationController
  before_action :set_snowboot, only:[:edit,:update,:destroy, :set_top, :cancel_top,:set_recommend,:cancel_recommend]
  def index
    if params[:order]
      @snowboots = Snowboot.desc(params[:order])
    else
      @snowboots = Snowboot.recent
    end
    @snowboots = @snowboots.paginate(:page => params[:page], :per_page => 10)
  end

  def new
    @snowboot = Snowboot.new
    3.times{ @snowboot.qiniu_images.build }
  end

  def edit
    @snowboot.qiniu_images.build
  end

  # up
  def set_top
    @snowboot.set_top
    redirect_to admin_snowboots_path,notice:"设置成功"
  end

  def cancel_top
    @snowboot.cancel_top
    redirect_to admin_snowboots_path,notice:"设置成功"
  end

  #recommend
  def set_recommend
    @snowboot.set_recommend
    redirect_to admin_snowboots_path,notice:"设置成功"
  end

  def cancel_recommend
    @snowboot.cancel_recommend
    redirect_to admin_snowboots_path,notice:"设置成功"
  end

  def create
    @snowboot = Snowboot.new(snowboot_params)

    respond_to do |format|
      if @snowboot.save
        format.html { redirect_to admin_snowboots_path, notice: 'Snowboot was successfully created.' }
        format.json { render :show, status: :created, location: @snowboot }
      else
        format.html { render :new }
        format.json { render json: @snowboot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /snowboards/1
  # PATCH/PUT /snowboards/1.json
  def update
    respond_to do |format|
      if @snowboot.update(snowboot_params)
        format.html { redirect_to edit_admin_snowboot_path(@snowboot), notice: '成功编辑.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @snowboot.destroy
    respond_to do |format|
      format.html { redirect_to admin_snowboots_path, notice: 'Snowboard was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_snowboot
    @snowboot = Snowboot.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def snowboot_params
    params[:snowboot].permit(:name, :brand, :length, :material, :baseplate, :highback, :anklestrap, :toestrap, :ratchet,
                                :baseplatepadding, :flex,
                                :compatibility,:recommendeduse, :description, :style,
                                {
                                    qiniu_images_attributes: [:id,:colors,:original, :remote_original_url, :_destroy]
                                }
    );
  end
end