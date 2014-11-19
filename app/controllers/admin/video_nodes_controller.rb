class Admin::VideoNodesController < Admin::ApplicationController
  before_action :set_video_node, only: [:show, :edit, :update, :destroy]
  respond_to :html

  def index
    @video_nodes = VideoNode.all
  end

  def show
    respond_with(@video_node)
  end

  def new
    @video_node = VideoNode.new
  end

  def edit
  end

  def create
    @video_node = VideoNode.new(video_node_params)
    @video_node.save
    redirect_to admin_video_nodes_path
  end

  def update
    @video_node.update(video_node_params)
    redirect_to admin_video_nodes_path
  end

  def destroy
    @video_node.destroy
    redirect_to admin_video_nodes_path
  end

  private
  def set_video_node
    @video_node = VideoNode.find(params[:id])
  end

  def video_node_params
    params.require(:video_node).permit(:title,:description)
  end
end
