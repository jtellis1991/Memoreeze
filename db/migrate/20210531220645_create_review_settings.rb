class CreateReviewSettings < ActiveRecord::Migration[6.1]
  def change
    create_table :review_settings do |t|
      t.integer :user_id
      t.string  :reviews_per_day, default: 10
      t.integer :new_per_day, default: 10
      t.string  :time_zone, default: "Central Time (US & Canada)"

      t.timestamps
    end
  end
end
