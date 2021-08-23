class CreateReviewSettings < ActiveRecord::Migration[6.1]
  def change
    create_table :review_settings do |t|
      t.integer :user_id
      t.string  :reviews_per_day
      t.integer :new_per_day
      t.string  :time_zone

      t.timestamps
    end
  end
end
