class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.string :milliseconds_elapsed
      t.integer :card_account_id
      t.integer :grade_id
      t.integer :user_id

      t.timestamps
    end
  end
end
