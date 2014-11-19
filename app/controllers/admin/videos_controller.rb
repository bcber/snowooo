class Admin::VideosController < Admin::ApplicationController
  before_action :set_video, only: [:show, :edit, :update, :destroy, :up, :recommend]

  # GET /admin/videos
  # GET /admin/videos.json
  def index
    @videos = Video.desc(:created_at).paginate(:page => params[:page], :per_page => 10)
  end

  # GET /admin/videos/1
  # GET /admin/videos/1.json
  def show
  end

  # GET /admin/videos/new
  def new
    @video = Video.new
  end

  # GET /admin/videos/1/edit
  def edit
  end

  # POST /admin/videos
  # POST /admin/videos.json
  def create
    @video = Video.new(video_params)

    respond_to do |format|
      if @video.save
        format.html { redirect_to admin_videos_path, notice: 'Video was successfully updated.' }
        format.json { render :show, status: :created, location: @video }
      else
        format.html { render :new }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/videos/1
  # PATCH/PUT /admin/videos/1.json
  def update
    respond_to do |format|
      if @video.update(video_params)
        format.html { redirect_to admin_videos_path, notice: 'Video was successfully updated.' }
        format.json { render :show, status: :ok, location: @video }
      else
        format.html { render :edit }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/videos/1
  # DELETE /admin/videos/1.json
  def destroy
    @video.destroy
    respond_to do |format|
      format.html { redirect_to admin_videos_path, notice: 'Video was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # up
  def up
    if @video.update(up_at: Time.now)
      redirect_to videos_path
    end
  end

  def down
    if @video.update(up_at: Time.new(1970))
      redirect_to videos_path
    end
  end

  #recommend
  def recommend
    if @video.update(recommend_at: Time.now)
      redirect_to videos_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def video_params
      params[:video].permit(:url, :video_node_id)
    end
end
