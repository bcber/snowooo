class VideosController < ApplicationController
  before_action :set_video, only: [:show, :edit, :update, :destroy, :comment]
  respond_to :html
  load_and_authorize_resource

  def index
    @videos = Video.crawled
    respond_with(@videos)
  end

  def show
    @comment = Comment.new
    session[:reply_page] = url_for(@video)
  end

  def new
    @video = Video.new
  end

  def edit
  end

  def create
    @video = Video.new(video_params)
    @video.save
    respond_with(@video)
  end

  def update
    @video.update(video_params)
    respond_to do |format|
      format.html {redirect_to @video}
      format.js
    end
  end

  def destroy
    @video.destroy
    respond_with(@video)
  end

  private
    def set_video
      @video = Video.find(params[:id])
    end

    def video_params
      params.require(:video).permit(
        :link,
        {comments_attributes: [:_destroy, :user_id, :content]}
        )
    end
end
