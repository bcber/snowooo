class Post
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :content, type: String
  field :up_at, type: Time, default: Time.now
  field :recommend_at, type: Time, default: Time.now
  field :cover, type: String, default: "http://placekitten.com/g/600/200"

  has_many :comments, as: :commentable
  belongs_to :user
end
