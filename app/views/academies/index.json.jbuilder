json.array!(@academies) do |academy|
  json.extract! academy, 
  json.url academy_url(academy, format: :json)
end
