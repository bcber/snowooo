class Admin::ApplicationController < ApplicationController
  layout "admin"
  before_filter :require_admin

  def require_admin
    unless current_user and current_user.has_role? :admin
      render_404
    end
  end
  
  def set_active_menu
    @current = ["/" + ["cpanel",controller_name].join("/")]
  end
end