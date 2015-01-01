class AverageCache
  include Mongoid::BaseModel

  belongs_to :rater, :class_name => "User"
  belongs_to :rateable, :polymorphic => true
end
