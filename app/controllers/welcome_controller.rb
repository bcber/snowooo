class WelcomeController < ApplicationController
  def index
    @posts = Post.desc(:created_time).limit(10)
  end
end
  