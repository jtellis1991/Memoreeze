class CreateAssignments < ActiveRecord::Migration[6.1]
  def change
    create_table :assignments do |t|
      t.integer :course_id
      t.string  :resource_link_id
      t.string  :resource_link_title
      t.integer :deck_id

      t.timestamps
    end
  end
end
