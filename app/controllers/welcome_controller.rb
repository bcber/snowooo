class WelcomeController < ApplicationController
  def index
    top_posts = Post.desc(:up_at).limit(4).entries
    top_snowboards = Snowboard.desc(:up_at).limit(4).entries
    top_place = Place.desc(:up_at).limit(4).entries
    top_snowbindings = Snowbinding.desc(:up_at).limit(4).entries
    top_snowboots = Snowboot.desc(:up_at).limit(4).entries
    @top = []
    @top << top_posts
    @top << top_snowbindings
    @top << top_place
    @top << top_snowboards
    @top << top_snowboots
    @top.flatten!
    @top.sort_by! {|item| item.up_at }.reverse!

    @posts = Post.passed.desc(:created_at).limit(6)
    @places = Place.desc(:created_at).limit(8)
    @videos = Video.desc(:created_at).limit(6)
    @snowboards = Snowboard.desc(:created_at).limit(7)
    @snowbindings = Snowbinding.desc(:created_at).limit(7)
    @snowboots = Snowboot.desc(:created_at).limit(7)
    @comments = Comment.desc(:created_at).limit(6)
    set_seo_meta
  end
end
  