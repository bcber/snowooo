json.array!(@snowboots) do |snowboot|
  json.extract! snowboot, :id
  json.url snowboot_url(snowboot, format: :json)
end
