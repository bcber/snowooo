class Video
  include Mongoid::Document
  include Mongoid::Timestamps
  before_save :getVid
  after_save :addToWorker


  VIDPATTERN = /_([a-zA-Z0-9]+)\./

  validates :link, format: { with: /youku\.com\/v_show\/id_[\w]+\.html/,
    message: "not a youku link" }, uniqueness: true

  field :vid, type: String
  field :title, type: String
  field :link, type: String
  field :thumbnail, type: String
  field :description, type: String

  scope :crawled, ->{where(:title.nin => [nil,''])}

  has_many :comments, as: :commentable
  accepts_nested_attributes_for :comments
  
  def getVid
    mtch = VIDPATTERN.match link
    self.vid = mtch[1]
  end

  def addToWorker
    if self.title.blank? and self.thumbnail.blank? and self.description.blank? 
      VideoWorker.perform_async(self.id.to_s)
    end
  end
end
