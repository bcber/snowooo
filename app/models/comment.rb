class Comment
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Likeable

  field :content, type: String
  field :commentable_id, type:Integer
  field :commentable_type, type:String
  field :excellent, type: Integer, default:0

  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable

  belongs_to :user

  after_touch :check_if_top
  def check_if_top
    if self.likes_count > 5
      Notification.top_comment(self)
    end
  end

  def reply?
    self.commentable_type.downcase == 'comment'
  end

  def excellent?
    self.excellent != 0
  end

  after_save :notify
  def notify
    if self.reply?
      Notification.generate_comment(self)
    end
  end
end
