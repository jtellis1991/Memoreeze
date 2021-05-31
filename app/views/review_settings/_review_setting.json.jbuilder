json.extract! review_setting, :id, :user_id, :reviews_per_day, :new_per_day, :created_at, :updated_at
json.url review_setting_url(review_setting, format: :json)
