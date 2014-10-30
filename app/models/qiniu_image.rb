class QiniuImage
  include Mongoid::Document
  include Mongoid::Timestamps

  field :color
  field :original
  mount_uploader :original, QiniuimageUploader

  embedded_in :snowboard
end
