json.array!(@snowbindings) do |snowbinding|
  json.extract! snowbinding, :id
  json.url snowbinding_url(snowbinding, format: :json)
end
