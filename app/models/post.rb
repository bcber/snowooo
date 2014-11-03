class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::TaggableOn

  taggable_on :category

  field :title, type: String
  field :content, type: String
  field :up_at, type: Time, default: Time.now
  field :recommend_at, type: Time, default: Time.now
  field :cover, type: String
  mount_uploader :cover, PostCoverUploader

  has_many :comments, as: :commentable
  belongs_to :user
end
