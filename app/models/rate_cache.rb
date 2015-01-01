class RatingCache
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :cacheable, :polymorphic => true
end