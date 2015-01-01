class Review
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel

  field :good
  field :bad
  field :composite
  field :stars

  validates_presence_of :good, :bad, :composite, :stars
  validates_length_of :good,:bad,:composite, minimum:10 ,maximum:300

  belongs_to :reviewable, polymorphic: true
  belongs_to :user
end