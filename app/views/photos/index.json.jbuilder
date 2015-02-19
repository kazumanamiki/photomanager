json.array!(@photos) do |photo|
  json.extract! photo, :id, :number, :place, :lens
  json.url photo_url(photo, format: :json)
end
