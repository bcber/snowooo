class Image
  include Mongoid::Document
  include Mongoid::Timestamps

  COLOR_OPTIONS = %w{ red white green gray}

  field :color, type: String
  field :original_url, type: String
  field :full_url, type: String

  embedded_in :snowboard
end
