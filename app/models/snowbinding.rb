class Snowbinding
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel
  include Mongoid::Topable
  include Mongoid::Rateable
  include Mongoid::Recommendable
  ratyrate_rateable

  BRANDS = Snowbinding.pluck(:brand).flatten.uniq.reject{|brand| brand.blank?}
  MATERIALS = %w{polycarbonate nylon plastic aluminum steel}
  FLEXS = %w{soft medium stiff}
  MOUNTS = %w{4-hole channel 3D}

  field :name
  field :brand
  field :material
  field :baseplate
  field :highback
  field :anklestrap
  field :toestrap
  field :ratchet
  field :baseplatepadding
  field :flex
  field :compatibility
  field :recommendeduse
  field :description
  field :style
  field :cover
  mount_uploader :cover, QiniuimageUploader

  field :comment_count ,type: Integer, default: 0

  field :up_at, type: Time, default: Time.new(1970)
  field :recommend_at, type: Time, default: Time.new(1970)

  STYLES_OPTIONS = %w{ women men kid }
  embeds_many :images, inverse_of: :images

  embeds_many :qiniu_images, :cascade_callbacks => true
  accepts_nested_attributes_for :qiniu_images, reject_if: :all_blank, allow_destroy: true

  has_many :comments, as: :commentable, dependent: :destroy
  accepts_nested_attributes_for :comments
  alias :title :name

  has_many :reviews, as: :reviewable
end
