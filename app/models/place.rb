class Place
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Letsrate

  field :name
  field :region
  field :address
  field :site
  field :description
  field :phone
  field :xcoordinate, type:BigDecimal
  field :ycoordinate, type:BigDecimal
  field :up_at, type: Time, default: Time.new(1970)
  field :recommend_at, type: Time, default: Time.new(1970)
  field :cover
  mount_uploader :cover, QiniuimageUploader
  field :cover_img_url

  letsrate_rateable

  embeds_many :place_images, :cascade_callbacks => true
  accepts_nested_attributes_for :place_images, reject_if: :all_blank,allow_destroy: true
  has_many :comments, as: :commentable
  accepts_nested_attributes_for :comments
  alias :title :name
end
