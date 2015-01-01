class PostNode
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title
  field :description

  has_many :posts, dependent: :nullify
end
