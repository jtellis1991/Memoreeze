class CreateAssignments < ActiveRecord::Migration[6.1]
  def change
    create_table :assignments do |t|
      t.integer :course_id
      t.integer :user_id
      t.string  :resource_link_id
      t.string  :resource_link_title
      t.integer :deck_id
      t.integer :points_up, default: 1
      t.integer :points_down, default: 1

      t.timestamps
    end
  end
end
