class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel
  include Mongoid::TaggableOn
  include Mongoid::Paranoia
  include Mongoid::Topable
  include Mongoid::Recommendable

  taggable_on :category

  validates_presence_of :title,:content

  field :title
  field :content
  field :publish, type: Mongoid::Boolean, default: false, pre_processed: true
  field :comment_count ,type: Integer, default: 0
  field :cover

  mount_uploader :cover, PostCoverUploader
  has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :user
  belongs_to :post_node

  scope :published, -> { where(publish: true) }
  scope :unpublish, -> { where(publish: false) }
  scope :no_node, ->{where(post_node_id: nil)}

  default_scope -> { where(:post_node_id.ne => nil).where(:publish => true) }

  def set_publish
    self.update(publish: true)
  end

  def cancel_publish
    self.update(publish: false)
  end
end
