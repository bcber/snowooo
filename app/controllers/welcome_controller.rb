class WelcomeController < ApplicationController
  def index
    @top = []
    @top << Post.top.limit(5).entries
    @top << Snowboard.top.limit(5).entries
    @top << Place.top.limit(5).entries
    @top << Snowbinding.top.limit(5).entries
    @top << Snowboot.top.limit(5).entries
    @top.flatten!
    @top.sort_by! {|item| item.top_at }.reverse!

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
  