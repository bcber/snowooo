class Admin::TopicsController < Admin::ApplicationController
  before_action :set_topic, only: [:destroy]
  def index
    @topics = Topic.desc(:created_at).paginate(:page => params[:page], :per_page => 10)
  end

  def destroy
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to admin_topics_path, notice: '帖子删除成功.' }
    end
  end

  private
  def set_topic
    @topic = Topic.find(params[:id])
  end
end