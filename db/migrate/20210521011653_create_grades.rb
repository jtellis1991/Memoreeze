class CreateGrades < ActiveRecord::Migration[6.1]
  def change
    create_table :grades do |t|
      t.integer :score
      t.integer :points_possible
      t.integer :enrollment_id
      t.integer :assignment_id
      t.text    :outcome_params

      t.timestamps
    end
  end
end
