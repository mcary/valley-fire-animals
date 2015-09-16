json.array!(@foster_homes) do |foster_home|
  json.extract! foster_home, :id, :name, :address, :details
  json.url foster_home_url(foster_home, format: :json)
end
