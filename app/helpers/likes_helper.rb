module LikesHelper
  def likeable_tag(likeable,opts={})
    return "" if likeable.blank?

    label = "#{likeable.likes_count} 人赞"
    label = "赞" if likeable.likes_count == 0

    if likeable.liked_by_user?(current_user)
      state = "liked"
      label+="(已赞)"
      icon = content_tag("i", "", class: "fa  fa-thumbs-up")
    else
      state = ""
      icon = content_tag("i", "", class: "fa fa-thumbs-o-up")
    end
    like_label = raw "#{icon} <span>#{label}</span>"

    link_to(like_label, "#", 'data-count' => likeable.likes_count,
            'data-state' => state, 'data-type' => likeable.class,'data-id' => likeable.id,
            class: 'likeable', onclick: "return Application.likeable(this);")
  end
end