class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  respond_to :html

  def index
    @posts = Post.desc(:created_at).paginate(page: params[:page], per_page: 10)
    @top_posts = Post.desc(:up_at).limit(3)
    @recommend_posts = Post.desc(:recommend_at).limit(10)
  end

  def show
    @recommend_posts = Post.asc(:recommend_at.desc).limit(10)
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    @post.save
    redirect_to @post
  end

  def update
    @post.update(post_params)
  end

  def destroy
    @post.destroy
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :content)
    end
end
