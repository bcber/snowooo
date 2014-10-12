class Video
  include Mongoid::Document
  field :vid, type: String
  field :title, type: String
  field :thumbnail, type: String
  field :bigThumbnail, type: String
end
