class Topic
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel
  include Mongoid::Likeable

  validates_presence_of :title,:content

  field :title, type: String
  field :content, type: String
  field :comment_count ,type: Integer, default: 0

  has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :user
  belongs_to :topic_node

  index likes_count: 1

  # scope
  scope :hot, -> { where( :comment_count.gte => 5) }
  scope :good, -> { where(:likes_count.gte => 5 )}
  scope :no_comment, -> { where( comment_count: 0)}
end
