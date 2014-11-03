class WelcomeController < ApplicationController
  def index
    @top_posts = Post.desc(:up_time).limit(4)
    @posts = Post.desc(:created_time).limit(6)
    @places = Place.desc(:created_time).limit(6)
    @videos = Video.desc(:created_time).limit(6)
    @snowboards = Snowboard.desc(:created_time).limit(7)
    @snowbindings = Snowbinding.desc(:created_time).limit(7)
    @snowboots = Snowboot.desc(:created_time).limit(7)
  end

  def gear
    @snowboards = Snowboard.desc(:created_time).limit(8)
    @snowbindings = Snowbinding.desc(:created_time).limit(8)
    @snowboots = Snowboot.desc(:created_time).limit(8)
  end
end
  