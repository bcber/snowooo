class Snowboot
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Letsrate
  letsrate_rateable

  STYLES = Snowboot.all.pluck(:style).uniq

  def self.create_scope(scopes)
    scopes.each do |s|
      scope s.to_sym, ->{ where(style: s.to_s) }
    end
  end

  create_scope STYLES

  field :name
  field :brand
  field :style
  field :description

  embeds_many :images, inverse_of: :images

  embeds_many :qiniu_images, :cascade_callbacks => true
  accepts_nested_attributes_for :qiniu_images, reject_if: :all_blank, allow_destroy: true

  has_many :comments, as: :commentable
  accepts_nested_attributes_for :comments
end
