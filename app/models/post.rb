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
  field :pass, type: Boolean, default: false
  field :comment_count ,type: Integer, default: 0
  field :cover
  mount_uploader :cover, PostCoverUploader

  scope :passed, -> { where(pass: true) }
  scope :nopassed, -> { where(pass: false) }
  scope :no_node, ->{where(post_node_id: nil)}
  default_scope ->{ where( pass: true,:post_node_id.ne => nil) }

  has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :user
  belongs_to :post_node
end
