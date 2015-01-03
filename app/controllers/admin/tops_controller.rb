class Admin::TopsController < Admin::ApplicationController
  def index
    @tops = Top.asc(:position)
  end

  # set position via draggable plugin
  def set_position
    if params[:new_position].present? and params[:old_position].present?
      Top.update_position(params[:new_position], params[:old_position])
      head :ok
    else
      head :bad_request
    end
  end
end