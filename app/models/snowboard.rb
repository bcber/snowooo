class Snowboard
  include Mongoid::Document
  include Mongoid::Timestamps

  STYLES = Snowboard.all.pluck(:style).uniq

  def self.create_scope(scopes)
    scopes.each do |s|
      scope s.to_sym, ->{ where(style: s.to_s) }
    end
  end

  create_scope STYLES
  
  def self.crawlAll
    snowboards = Snowboard.all.limit(5)
    snowboards.each do |snowboard|
      ImageWorker.perform_async(snowboard.id.to_s)
    end
  end

  

  # property
  field :name, type:String
  field :brand, type: String
  field :length, type: String
  field :profile, type: String
  field :shape, type: String
  field :style, type: String
  field :flex, type: String
  field :effectiveedge, type: String
  field :waistwidth, type: String
  field :sidecutradius, type: String
  field :stancewidth, type: String
  field :stancesetback, type: String
  field :mount, type: String
  field :core, type: String
  field :wrap, type: String
  field :sidewalls, type: String
  field :edge, type: String
  field :base, type: String
  field :recommendedriderweight, type: String
  field :recommendeduse, type: String
  field :manufacturerwarranty, type: String
  field :description, type: String
  field :origurl , type: String

  field :review, type: Hash

  embeds_many :images, store_as: "snowboard_imgs", inverse_of: :images
  accepts_nested_attributes_for :images, reject_if: -> (a) {
    a[:small].blank? or a[:medium].blank? or a[:large].blank?
  }, allow_destroy: true
  
end
