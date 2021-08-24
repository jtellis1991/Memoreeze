class CreateGrades < ActiveRecord::Migration[6.1]
  def change
    create_table :grades do |t|
      t.float :score
      t.integer :enrollment_id
      t.integer :assignment_id

      t.timestamps
    end
  end
end
