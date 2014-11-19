class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  respond_to :html

  def index
    posts = Post.passed
    @posts = posts.desc(:created_at).paginate(page: params[:page], per_page: 10)
    @top_posts = posts.desc(:up_at).limit(3)
    @recommend_posts = posts.desc(:recommend_at).limit(10)
    @comments = Comment.desc(:created_at).limit(6)
  end

  def show
    @recommend_posts = Post.passed.asc(:recommend_at.desc).limit(10)
    @comment = Comment.new
    session[:reply_page] = url_for(@post)
    set_seo_meta("#{@post.title}", "#{@post.title}")
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def category
    @posts = Post.tagged_with_on(:category,params[:category]).paginate(page:params[:page], per_page: 9)
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to posts_path, notice: "您的文章已提交审核，请耐心等待"
    else
      render action: 'edit'
    end
  end

  def update
    @post.update(post_params)
    redirect_to @post
  end

  def destroy
    @post.destroy
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit( :title, :content, :cover, :remote_cover_url, :tag_string ,:category_list)
    end
end
