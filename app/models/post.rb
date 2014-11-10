class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::TaggableOn
  taggable_on :category

  validates_presence_of :title,:content

  field :title
  field :content
  field :up_at, type: Time, default: Time.new(1970)
  field :recommend_at, type: Time, default: Time.new(1970)
  field :pass, type: Boolean, default: -> { false }
  field :comment_count ,type: Integer, default: 0
  field :cover
  mount_uploader :cover, PostCoverUploader

  scope :passed, -> { where(pass: true) }
  scope :nopassed, -> { where(pass: false) }

  has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :user
end
