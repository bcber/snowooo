class OverallAverage
  include Mongoid::BaseModel

  belongs_to :rateable, :polymorphic => true
end

