class Bbs::TopicsController < Bbs::ApplicationController
  before_action :set_topic, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  respond_to :html

  def index
    @topics = Topic.desc(:created_at).paginate(page: params[:page], per_page: 10)
  end

  def node
    @node = TopicNode.find(params[:node_id])
    @topics = @node.topics.desc(:created_at).paginate(page: params[:page], per_page: 10)
    render action: 'index'
  end

  def show
    @comment = Comment.new
    session[:reply_page] = url_for(['bbs',@topic])
    set_seo_meta("#{@topic.title}", "#{@topic.title}")
  end

  def new
    @topic = Topic.new
  end

  def edit
  end

  def create
    @topic = Topic.new(topic_params)
    @topic.user = current_user
    if @topic.save
      redirect_to(bbs_topic_path(@topic), notice: t('topics.create_topic_success'))
    else
      render 'edit'
    end
  end

  def update
    @topic.update(topic_params)
    redirect_to bbs_topic_path(@topic)
  end

  def destroy
    @topic.destroy
    redirect_to bbs_topics_path, notice: "删除成功"
  end

  private
    def set_topic
      @topic = Topic.find(params[:id])
    end

    def topic_params
      params.require(:topic).permit(:title,:content,:topic_node_id)
    end
end
