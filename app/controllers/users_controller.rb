class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy, :confirm]
  # load_and_authorize_resource

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = current_user
  end

  def check_in
    @user = current_user
    @user.check_in
    redirect_to profile_path, notice:"签到成功，获得积分10，经验10"
  end

  def confirm
    respond_to do |format|
      if @user.confirm!
        format.html {redirect_to @user, notice: 'User confirmed, but not in a normal way!'}
      else
        format.html {redirect_to @user, alert: 'User confirm fail!'}
      end
    end
  end

  def remove_not_confirmed
    User.where(confirmed_at: nil).delete
    redirect_to users_path
  end

  def profile
    @user = current_user
    render action:'show'
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: t('users.messages.update_success') }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
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

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
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
