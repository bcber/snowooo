class Admin::SnowbootsController < Admin::ApplicationController
  def index
    @snowboots = Snowboot.desc(:created_at).paginate(:page => params[:page], :per_page => 10)
  end
end