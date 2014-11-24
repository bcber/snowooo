class Snowboard
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Letsrate
  include Mongoid::TaggableOn
  taggable_on :colors


  letsrate_rateable

  STYLES = Snowboard.pluck(:style).flatten.uniq.reject{|a|a.blank?}
  BRANDS = Snowboard.pluck(:brand).flatten.uniq.reject{|a|a.blank?}
  SHAPES = %w{twin directional tapered}
  FLEXS = %w{soft medium stiff}

  # property
  field :name
  field :brand
  field :length
  field :profile
  field :shape
  field :style
  field :flex
  field :effectiveedge
  field :waistwidth
  field :sidecutradius
  field :stancewidth
  field :stancesetback
  field :mount
  field :core
  field :wrap
  field :sidewalls
  field :edge
  field :base
  field :recommendedriderweight
  field :recommendeduse
  field :manufacturerwarranty
  field :description
  field :origurl
  field :up_at, type: Time, default: Time.new(1970)
  field :recommend_at, type: Time, default: Time.new(1970)
  field :cover
  mount_uploader :cover, QiniuimageUploader
  field :comment_count ,type: Integer, default: 0

  embeds_many :qiniu_images, :cascade_callbacks => true
  accepts_nested_attributes_for :qiniu_images, reject_if: :all_blank, allow_destroy: true

  embeds_many :images, store_as: "snowboard_imgs", inverse_of: :images
  accepts_nested_attributes_for :images, reject_if: -> (a) {
    a[:small].blank? or a[:medium].blank? or a[:large].blank?
  }, allow_destroy: true

  has_many :comments, as: :commentable, dependent: :destroy
  accepts_nested_attributes_for :comments
  alias :title :name
end
