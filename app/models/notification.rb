class Notification
  include Mongoid::Document
  include Mongoid::Timestamps

  scope :unread, -> {where(read: 0)}
  scope :readed, -> {where(:read.gt => 0)}

  field :title
  field :body
  field :read, type: Integer, default: 0
  index read: 1

  field :notificable_id
  field :notificable_type, type:String

  belongs_to :user

  def read?
    self.read != 0
  end

  def notificable
    if self.notificable_type.constantize.where(id:self.notificable_id).exists?
      notificable = self.notificable_type.constantize.find(self.notificable_id)
    else
      notificable = nil
    end
    if notificable.present? and self.notificable_type.downcase == 'comment'
      findtopcommentable(notificable)
    else
      notificable
    end
  end

  def mark_as_read
    self.update_attributes(read: 1)
  end

  def mark_as_unread
    self.update_attributes(read: 0)
  end

  def self.generate_comment(comment)
    user = comment.commentable_type.constantize.find(comment.commentable_id).user
    id = comment.id
    body = <<-CONTENT
        <h6>#{user.name}说:</h6>
        <p>#{comment.content}</p>
    CONTENT
    notification = Notification.new({
                                        title:'有人回复了你的评论',
                                        body: body,
                                        notificable_id: id,
                                        notificable_type: 'Comment'})
    notification.user = user
    notification.save!
  end

  def self.generate_pass_post(post)
    Notification.new({
        title:"您发表的资讯 < #{post.title} >已通过审核",
        body: "获得 积分 +10,经验 +10, 金币 +5, 威望 +5",
        notificable_id: post.id,
        notificable_type: 'Post',
        user_id: post.user.id
    }).save!
  end

  def self.top_post(post)
    Notification.new({
        title: "您发表的资讯已被置顶",
        body:"获得: 金币 +30, 经验 +30, 金币 +30, 威望 +30",
        notificable_id: post.id,
        notificable_type: 'Post',
        user_id: post.user.id
    }).save!
  end

  def self.top_comment(comment)
    Notification.new({
        title: "您发表的评论成为了精品评论",
        body:"#{comment.content}",
        notificable_id: comment.id,
        notificable_type: 'Comment',
        user_id: comment.user.id
    }).save!
  end

  def self.generate_comment_topic(topic, comment)
    body = <<-COMMENT
      <h6>#{comment.user.name}说:</h6>
      <p>
        #{comment.content}
      </p>
    COMMENT
    Notification.new({
        title: "您发的帖子 < #{topic.title}> 有人评论了.",
        body: body,
        notificable_id: topic.id,
        notificable_type: "Topic",
        user_id: topic.user.id
    }).save!
  end

  def self.generate_comment_post(post,comment)
    body = <<-COMMET
      <h6>#{comment.user.name}说:</h6>
      <p>
        #{comment.content}
      </p>
    COMMET
    Notification.new({
      title: "您发表的资讯 < #{post.title}> 有人评论了",
      body: body,
      notificable_id: post.id,
      notificable_type: 'Post',
      user_id: post.user.id
    }).save!
  end

  private
  def findtopcommentable(comment)
    if comment.reply?
      comment = comment.commentable
      findtopcommentable(comment)
    else
      comment.commentable
    end
  end
end
