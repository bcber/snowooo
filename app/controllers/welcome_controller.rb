class WelcomeController < ApplicationController
  def index
    @top = Top.asc(:position).limit(5).entries.map{ |e| e.model }

    @posts = Post.recent.limit(6)
    @places = Place.recent.limit(8)
    @videos = Video.recent.limit(6)
    @snowboards = Snowboard.recent.limit(7)
    @snowbindings = Snowbinding.recent.limit(7)
    @snowboots = Snowboot.recent.limit(7)
    @comments = Comment.recent.limit(6)
    set_seo_meta
  end
end
  