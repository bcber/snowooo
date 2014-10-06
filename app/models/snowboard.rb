class Snowboard
  include Mongoid::Document

  # property
  field :name, type:String
  field :images, type:Array
  field :review, type: Hash
  field :brand, type: String
  field :length, type: Array
  field :profile, type: String
  field :shape, type: String
  field :color, type: String
  field :flex, type: Array
  field :effectiveEdge, type: Array
  field :waistWidth, type: Array
  field :sidecutRadius, type: Array
  field :stanceWidth, type: String
  field :stanceSetback, type: String
  field :mount, type: String
  field :core, type: Array
  field :wrap, type: String
  field :sidewalls, type: String
  field :base, type: String
  field :recommendedRiderWeight, type: Array
  field :recommendedUse, type: String
end
