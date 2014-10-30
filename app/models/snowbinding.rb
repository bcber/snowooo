class Snowbinding
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Letsrate
  letsrate_rateable

  STYLES = Snowbinding.all.pluck(:style).uniq

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

  STYLES_OPTIONS = %w{ women men kid }
  embeds_many :images, inverse_of: :images

  embeds_many :qiniu_images, :cascade_callbacks => true
  accepts_nested_attributes_for :qiniu_images, reject_if: :all_blank, allow_destroy: true

  has_many :comments, as: :commentable
  accepts_nested_attributes_for :comments

end