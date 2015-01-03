class Admin::SnowbindingsController < Admin::ApplicationController
  before_action :set_snowbinding, only:[:edit,:update,:destroy, :set_top, :cancel_top, :set_recommend, :cancel_recommend]
  def index
    if params[:order]
      @snowbindings = Snowbinding.desc(params[:order])
    else
      @snowbindings = Snowbinding.recent
    end
    @snowbindings = @snowbindings.paginate(:page => params[:page], :per_page => 10)
  end

  def new
    @snowbinding = Snowbinding.new
    3.times{ @snowbinding.qiniu_images.build }
  end

  def edit
    @snowbinding.qiniu_images.build
  end

  def create
    @snowbinding = Snowbinding.new(snowbinding_params)

    respond_to do |format|
      if @snowbinding.save
        format.html { redirect_to admin_snowbindings_path, notice: 'Snowbinding was successfully created.' }
        format.json { render :show, status: :created, location: @snowbinding }
      else
        format.html { render :new }
        format.json { render json: @snowbinding.errors, status: :unprocessable_entity }
      end
    end
  end

  # up
  def set_top
    @snowbinding.set_top
    redirect_to admin_snowbindings_path, notice: "设置成功"
  end

  def cancel_top
    @snowbinding.cancel_top
    redirect_to admin_snowbindings_path, notice: "设置成功"
  end

  #recommend
  def set_recommend
    @snowbinding.set_recommend
    redirect_to admin_snowbindings_path, notice: "设置成功"
  end

  def cancel_recommend
    @snowbinding.cancel_recommend
    redirect_to admin_snowbindings_path, notice: "设置成功"
  end

  # PATCH/PUT /snowboards/1
  # PATCH/PUT /snowboards/1.json
  def update
    respond_to do |format|
      if snowbinding.update(snowbinding_params)
        format.html { redirect_to edit_admin_snowbinding_path(snowbinding), notice: '成功编辑.' }
        format.json { render :show, status: :ok, location: snowbinding }
      else
        format.html { render :edit }
        format.json { render json: snowbinding.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @snowbinding.destroy
    respond_to do |format|
      format.html { redirect_to admin_snowbindings_path, notice: 'Snowboard was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_snowbinding
    @snowbinding = Snowbinding.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def snowbinding_params
    params[:snowbinding].permit(:name, :brand, :length, :material, :baseplate, :highback, :anklestrap, :toestrap, :ratchet,
                              :baseplatepadding, :flex,
                              :compatibility,:recommendeduse, :description, :style,
                              {
                                  qiniu_images_attributes: [:id,:colors,:original, :remote_original_url, :_destroy]
                              }
    );
  end
end