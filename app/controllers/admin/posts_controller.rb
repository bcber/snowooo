class Admin::PostsController < Admin::ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :set_top, :cancel_top, :set_recommend,:cancel_recommend ,:pass]

  # GET /admin/posts
  # GET /admin/posts.json
  def index
    posts = Post.unscoped
    if params[:pass].present? and params[:pass] == '1'
        posts = posts.passed
    elsif params[:pass].present? and params[:pass] == '0'
        posts = posts.nopassed
    else
      posts = posts.recent.paginate(page: params[:page], per_page: 10)
    end
    @posts = posts
  end

  def top_posts
    @posts = Post.top
  end

  # GET /admin/posts/1
  # GET /admin/posts/1.json
  def show
  end

  def pass
    if @post.update(pass: true)
      Notification.generate_pass_post(@post)
      @post.user.member_rule_post
      redirect_to admin_posts_path
    end
  end

  # up
  def set_top
    @post.set_top
    if not @post.user.isAdmin
      @post.user.member_rule_top_post
      Notification.top_post(@post)
    end
    redirect_to admin_posts_path, notice:"设置成功"
  end

  def cancel_top
    @post.cancel_top
    redirect_to admin_posts_path, notice:"设置成功"
  end

  def set_recommend
    @post.set_recommend
    redirect_to admin_posts_path, notice:"设置成功"
  end

  def cancel_recommend
    @post.cancel_recommend
    redirect_to admin_posts_path, notice:"设置成功"
  end

  #recommend
  def recommend
    if @post.update(recommend_at: Time.now)
      redirect_to admin_posts_path
    end
  end

  # GET /admin/posts/new
  def new
    @post = Post.new
  end

  # GET /admin/posts/1/edit
  def edit
  end

  # POST /admin/posts
  # POST /admin/posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/posts/1
  # PATCH/PUT /admin/posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/posts/1
  # DELETE /admin/posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to admin_posts_path, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_post
    @post = Post.unscoped.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params[:post]
  end
end
