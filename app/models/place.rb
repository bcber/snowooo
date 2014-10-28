class Place
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Letsrate
  field :name
  field :region
  field :address
  field :site
  field :description
  field :cover
  field :phone
  field :xcoordinate, type:BigDecimal
  field :ycoordinate, type:BigDecimal

  letsrate_rateable

  mount_uploader :cover, PlaceImageUploader
  embeds_many :place_images, :cascade_callbacks => true
  accepts_nested_attributes_for :place_images, reject_if: :all_blank,allow_destroy: true
  has_many :comments, as: :commentable
  accepts_nested_attributes_for :comments
end
