json.extract! user, :id, :role, :tool_consumer_id, :created_at, :updated_at
json.url user_url(user, format: :json)
