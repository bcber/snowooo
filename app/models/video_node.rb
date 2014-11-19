class VideoNode
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title
  field :description

  has_many :videos, dependent: :destroy
end
