json.array!(@videos) do |video|
  json.extract! video, :id, :vid, :title, :thumbnail, :bigThumbnail
  json.url video_url(video, format: :json)
end
