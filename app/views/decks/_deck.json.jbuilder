json.extract! deck, :id, :name, :user_id, :assignment_id, :created_at, :updated_at
json.url deck_url(deck, format: :json)
