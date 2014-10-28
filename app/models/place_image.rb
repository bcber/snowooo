class PlaceImage
  include Mongoid::Document
  include Mongoid::Timestamps
  field :original
  mount_uploader :original, PlaceImageUploader
  embedded_in :place
end