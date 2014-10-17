class VideoWorker
  include Sidekiq::Worker

  @@client_id = "c11677d902e397c0"
  @@client_secret = "797976d12157d7c1db2c814313ecb192"
  @@show_basic = "https://openapi.youku.com/v2/videos/show_basic.json"
  @@show = "https://openapi.youku.com/v2/videos/show.json"

  def perform(id)
    video = Video.find(id)
    url = @@show+"?client_id=#{@@client_id}&video_id=#{video.vid}"
    info = JSON.parse(RestClient.get url)
    video.title = info["title"]
    video.thumbnail = info["thumbnail"]
    video.description = info["description"]
    video.save!
  end

end