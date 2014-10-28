class Admin::SnowboardsController < Admin::ApplicationController
  def index
    @snowboards = Snowboard.desc(:created_at).paginate(:page => params[:page], :per_page => 10)
  end
end