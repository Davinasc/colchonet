json.extract! user, :id, :full_name, :bio, :password, :email, :location, :created_at, :updated_at
json.url user_url(user, format: :json)