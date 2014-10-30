class Admin::PostsController < Admin::ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :up, :recommend]

  # GET /admin/posts
  # GET /admin/posts.json
  def index
    @posts = Post.desc(:created_at).paginate(page: params[:page], per_page: 10)
  end

  # GET /admin/posts/1
  # GET /admin/posts/1.json
  def show
  end

  # up
  def up
    if @post.update(up_at: Time.now)
      redirect_to admin_posts_path
    end
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
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params[:post]
    end
end
