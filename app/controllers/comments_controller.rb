class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_filter :require_user
  respond_to :html

  def index
    commentable = find_commentable
    @comments = commentable.comments
  end

  def show
    respond_with(@comment)
  end

  def new
    @commentable = find_commentable
    @comment = @commentable.comments.build
  end

  def new_reply
    @comment_to_reply = Comment.find(params[:id])
  end

  def reply
    @comment_to_reply = Comment.find(params[:id])
    @comment = @comment_to_reply.comments.build(comment_params)
    @comment.user = current_user
    @comment.save
    redirect = session[:reply_page]
    session[:reply_page] = nil
    redirect_to redirect
  end

  def edit
  end

  def create
    @commentable = find_commentable
    @comment = @commentable.comments.build(comment_params)
    @comment.user = current_user
    if @comment.commentable_type.downcase == 'post'
        Notification.generate_comment_post(@commentable,@comment)
    end

    if @comment.commentable_type.downcase == 'topic'
      Notification.generate_comment_topic(@commentable,@comment)
    end

    respond_to do |format|
      if @comment.save
        @commentable.inc(comment_count: 1)
        format.html { redirect_to @commentable, notice: '评论成功.' }
        format.js
      else
        format.html { render :new }
        format.js
      end
    end
  end

  def update
    @comment.update(comment_params)
    respond_with(@comment)
  end

  def destroy
    @comment.destroy
    respond_with(@comment)
  end

  private
    def find_commentable
      params.each do |name, value|
        if name =~ /(.+)_id$/
          return $1.classify.constantize.find(value)
        end
      end
      nil
    end
    
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:content)
    end
end
