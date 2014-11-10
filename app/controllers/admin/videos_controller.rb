class Admin::VideosController < Admin::ApplicationController
  before_action :set_admin_video, only: [:show, :edit, :update, :destroy, :up, :recommend]

  # GET /admin/videos
  # GET /admin/videos.json
  def index
    @admin_videos = Video.desc(:created_at).paginate(:page => params[:page], :per_page => 10)
  end

  # GET /admin/videos/1
  # GET /admin/videos/1.json
  def show
  end

  # GET /admin/videos/new
  def new
    @admin_video = Video.new
  end

  # GET /admin/videos/1/edit
  def edit
  end

  # POST /admin/videos
  # POST /admin/videos.json
  def create
    @admin_video = Video.new(admin_video_params)

    respond_to do |format|
      if @admin_video.save
        format.html { redirect_to @admin_video, notice: '成功创建视频' }
        format.json { render :show, status: :created, location: @admin_video }
      else
        format.html { render :new }
        format.json { render json: @admin_video.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/videos/1
  # PATCH/PUT /admin/videos/1.json
  def update
    respond_to do |format|
      if @admin_video.update(admin_video_params)
        format.html { redirect_to @admin_video, notice: 'Video was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_video }
      else
        format.html { render :edit }
        format.json { render json: @admin_video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/videos/1
  # DELETE /admin/videos/1.json
  def destroy
    @admin_video.destroy
    respond_to do |format|
      format.html { redirect_to admin_videos_path, notice: 'Video was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # up
  def up
    if @admin_video.update(up_at: Time.now)
      redirect_to admin_videos_path
    end
  end

  def down
    if @admin_video.update(up_at: Time.new(1970))
      redirect_to admin_videos_path
    end
  end

  #recommend
  def recommend
    if @admin_video.update(recommend_at: Time.now)
      redirect_to admin_videos_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_video
      @admin_video = Video.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_video_params
      params[:video].permit(:url)
    end
end
