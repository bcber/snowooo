class Snowbinding
  include Mongoid::Document

  STYLES = Snowbinding.all.pluck(:style).uniq


  field :name, type:String
  field :brand, type: String
  field :style, type: String
  

  STYLES_OPTIONS = %w{ women men kid }
  embeds_many :images, inverse_of: :images
end
