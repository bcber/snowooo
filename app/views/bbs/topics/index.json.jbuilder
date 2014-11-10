json.array!(@bbs_topics) do |bbs_topic|
  json.extract! bbs_topic, :id, :content
  json.url bbs_topic_url(bbs_topic, format: :json)
end
