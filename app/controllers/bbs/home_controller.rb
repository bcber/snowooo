class Bbs::HomeController < Bbs::ApplicationController
  def index
    @topics = Topic.desc(:created_at).limit(10)
  end
end