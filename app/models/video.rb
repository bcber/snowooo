class Video
  include Mongoid::Document
  include Mongoid::Timestamps
  before_save :getVid
  after_save :addToWorker


  VIDPATTERN = /_([a-zA-Z0-9]+)\./

  validates :url, format: { with: /youku\.com\/v_show\/id_[\w]+\.html/,
    message: "不是优酷的链接" }, uniqueness: true

  field :vid, type: String
  field :title, type: String
  field :url, type: String
  field :thumbnail, type: String
  field :description, type: String

  field :up_at, type: Time, default: Time.new(1970)
  field :recommend_at, type: Time, default: Time.new(1970)

  scope :crawled, ->{where(:title.nin => [nil,''])}

  has_many :comments, as: :commentable
  accepts_nested_attributes_for :comments
  
  def getVid
    mtch = VIDPATTERN.match url
    self.vid = mtch[1]
  end

  def addToWorker
    if self.title.blank?
      logger.info "*"*60
      logger.info "add video to queue"
      VideoWorker.perform_async(self.id.to_s)
    end
  end
end
