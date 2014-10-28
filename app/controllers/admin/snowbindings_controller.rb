class Admin::SnowbindingsController < Admin::ApplicationController
  def index
    @snowbindings = Snowbinding.desc(:created_at).paginate(:page => params[:page], :per_page => 10)
  end
end