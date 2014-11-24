class Image
  include Mongoid::Document
  include Mongoid::Timestamps

  # COLOR_OPTIONS = %w{ red white green gray}

  field :colors
  field :small
  field :medium
  field :large

  field :qismall
  field :qimedium
  field :qilarge

  embedded_in :snowboard, inverse_of: :snowboard_images
  embedded_in :snowboot, inverse_of: :snowboot_images
  embedded_in :snowbinding, inverse_of: :snowbinding_images
end
