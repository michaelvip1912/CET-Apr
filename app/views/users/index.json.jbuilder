json.array!(@users) do |user|
  json.extract! user, :encode, :name, :academy_encode, :password_digest, :remember_token
  json.url user_url(user, format: :json)
end
