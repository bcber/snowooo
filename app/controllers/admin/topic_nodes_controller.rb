class Admin::TopicNodesController < Admin::ApplicationController
  before_action :set_topic_node, only: [:show, :edit, :update, :destroy]
  respond_to :html

  def index
    @topic_nodes = TopicNode.all
  end

  def show
    respond_with(@topic_node)
  end

  def new
    @topic_node = TopicNode.new
    respond_with(@topic_node)
  end

  def edit
  end

  def create
    @topic_node = TopicNode.new(topic_node_params)
    @topic_node.save
    redirect_to admin_topic_nodes_path
  end

  def update
    @topic_node.update(topic_node_params)
    redirect_to admin_topic_nodes_path
  end

  def destroy
    @topic_node.destroy
    redirect_to admin_topic_nodes_path
  end

  private
  def set_topic_node
    @topic_node = TopicNode.find(params[:id])
  end

  def topic_node_params
    params.require(:topic_node).permit(:title,:description)
  end
end
