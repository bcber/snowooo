class Admin::SettingsController < Admin::ApplicationController
  def index
    @settings = Setting.all
  end

  def edit
    @setting = Setting.find(params[:id])
  end

  def update
    @setting = Setting.find(params[:id])

    if @setting.update_attributes(params[:setting].permit!)
      redirect_to admin_settings_path, notice: "success"
    else  
      render action: "edit"
    end
  end
end
