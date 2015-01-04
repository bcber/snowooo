class UsersController < ApplicationController
  before_action :set_user, only: [:show ]
  load_and_authorize_resource

  def check_in
    @user = current_user
    @user.check_in
    redirect_to profile_path, notice:"签到成功，获得积分10，经验10"
  end

  def remove_not_confirmed
    User.where(confirmed_at: nil).delete
    redirect_to users_path
  end

  def profile
    @user = current_user
    session[:reply_page] = url_for(@user)
    render action:'show'
  end

  def edit
    @user = current_user
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to profile_path, notice: '更新个人资料成功.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name,:description,:avatar,:remote_avatar_url ,:roles => [])
    end
end
