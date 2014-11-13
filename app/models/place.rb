class Place
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Letsrate
  include Mongoid::TaggableOn

  field :name
  field :address
  field :site
  field :description
  field :phone
  field :xcoordinate, type:BigDecimal, default: 1
  field :ycoordinate, type:BigDecimal, default: 1
  field :level,type:Integer, default:11
  field :up_at, type: Time, default: Time.new(1970)
  field :recommend_at, type: Time, default: Time.new(1970)
  field :cover
  field :comment_count ,type: Integer, default: 0
  mount_uploader :cover, QiniuimageUploader
  field :cover_img_url

  letsrate_rateable

  embeds_many :place_images, :cascade_callbacks => true
  accepts_nested_attributes_for :place_images, reject_if: :all_blank,allow_destroy: true
  has_many :comments, as: :commentable, dependent: :destroy
  accepts_nested_attributes_for :comments
  alias :title :name
end
