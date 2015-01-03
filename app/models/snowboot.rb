class Snowboot
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel
  include Mongoid::Topable
  include Mongoid::Rateable
  include Mongoid::Recommendable
  ratyrate_rateable

  STYLES = Snowboot.all.pluck(:style).uniq.reject{|a|a.blank?}

  field :name
  field :brand
  field :style
  field :description
  field :cover
  mount_uploader :cover, QiniuimageUploader
  field :comment_count ,type: Integer, default: 0

  embeds_many :images, inverse_of: :images

  embeds_many :qiniu_images, :cascade_callbacks => true
  accepts_nested_attributes_for :qiniu_images, reject_if: :all_blank, allow_destroy: true

  has_many :comments, as: :commentable, dependent: :destroy
  accepts_nested_attributes_for :comments
  alias :title :name

  has_many :reviews, as: :reviewable
end
