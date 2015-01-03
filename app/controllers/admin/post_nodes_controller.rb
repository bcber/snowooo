class Admin::PostNodesController < Admin::ApplicationController
  before_action :set_post_node, only: [:show,:edit,:update,:destroy]
  def index
    @post_nodes = PostNode.all
  end

  def new
    @post_node = PostNode.new
  end

  def edit
  end

  def show
  end

  def create
    @post_node = PostNode.new(post_node_params)
    @post_node.save
    redirect_to admin_post_nodes_path
  end

  def update
    @post_node.update(post_node_params)
    redirect_to edit_admin_post_node_path(@post_node)
  end

  def destroy
    @post_node.destroy
    redirect_to admin_post_nodes_path
  end

  private

  def set_post_node
    @post_node = PostNode.unscoped.find(params[:id])
  end

  def post_node_params
    params.require(:post_node).permit(:title,:description)
  end
end