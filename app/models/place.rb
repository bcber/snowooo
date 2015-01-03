class Place
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel
  include Mongoid::Topable
  include Mongoid::TaggableOn
  include Mongoid::Rateable
  include Mongoid::Recommendable
  ratyrate_rateable

  taggable_on :regions, index: true
  validates_format_of :coordinate, with: /-?[\d]{1,3}\.[\d]{1,6},-?[\d]{1,3}\.[\d]{1,6}/, allow_blank: true

  field :name
  field :address
  field :site
  field :description
  field :phone
  field :show_map, type: Boolean, default:false
  field :coordinate
  field :level,type:Integer, default:11
  field :up_at, type: Time, default: Time.new(1970)
  field :recommend_at, type: Time, default: Time.new(1970)
  field :cover
  field :comment_count ,type: Integer, default: 0
  mount_uploader :cover, QiniuimageUploader
  field :cover_img_url

  embeds_many :place_images, :cascade_callbacks => true
  accepts_nested_attributes_for :place_images, reject_if: :all_blank,allow_destroy: true
  has_many :reviews, as: :reviewable

  alias :title :name

  def self.get_tags_on(field)
    Place.pluck(field.to_sym).flatten!.uniq
    # ["国内","国外"]
  end

  def self.get_tags_count(field, value)
    Place.tagged_with_on(field.to_sym, value).count
    # 1
  end

  def xcoordinate
    if self.coordinate.present?
      return self.coordinate.split(/,|，/)[0]
    end
    0
  end

  def ycoordinate
    if self.coordinate.present?
      return self.coordinate.split(/,|，/)[1]
    end
    0
  end
end
