class TopicNode
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title
  field :description

  has_many :topics
end
