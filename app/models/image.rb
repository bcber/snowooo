class Image
  include Mongoid::Document
  include Mongoid::Timestamps

  # COLOR_OPTIONS = %w{ red white green gray}

  field :color, type: String
  field :small, type: String
  field :medium, type: String
  field :large, type: String

  field :qismall, type: String
  field :qimedium, type:String
  field :qilarge, type:String

  embedded_in :snowboard, inverse_of: :snowboard_images
  embedded_in :snowboot, inverse_of: :snowboot_images
end
