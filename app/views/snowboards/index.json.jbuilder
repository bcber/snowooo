json.array!(@snowboards) do |snowboard|
  json.extract! snowboard, :id
  json.url snowboard_url(snowboard, format: :json)
end
