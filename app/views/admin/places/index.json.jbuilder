json.array!(@admin_places) do |admin_place|
  json.extract! admin_place, :id
  json.url admin_place_url(admin_place, format: :json)
end
