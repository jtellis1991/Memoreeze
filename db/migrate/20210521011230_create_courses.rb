class CreateCourses < ActiveRecord::Migration[6.1]
  def change
    create_table :courses do |t|
      t.integer :tool_consumer_id

      t.timestamps
    end
  end
end
