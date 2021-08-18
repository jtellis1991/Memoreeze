class CreateCourses < ActiveRecord::Migration[6.1]
  def change
    create_table :courses do |t|
      t.integer :tool_consumer_id
      t.integer :user_id
      t.string  :context_id
      t.string  :context_title

      t.timestamps
    end
  end
end
