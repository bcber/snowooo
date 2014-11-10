class Bbs::TopicNodesController < Bbs::ApplicationController
  before_action :set_topic_node, only: [:show, :edit, :update, :destroy]
  respond_to :html
  def index
    @topic_nodes = TopicNode.all
  end

  def show
  end

  private
    def set_topic_node
      @topic_node = TopicNode.find(params[:id])
    end

    def topic_node_params
      params.require(:topic_node).permit(:title)
    end
end
