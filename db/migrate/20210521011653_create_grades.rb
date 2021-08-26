class CreateGrades < ActiveRecord::Migration[6.1]
  def change
    create_table :grades do |t|
      t.integer :score
      t.integer :points_possible
      t.integer :enrollment_id
      t.integer :assignment_id
      t.string  :lis_outcome_service_url
      t.string  :lis_result_sourcedid

      t.timestamps
    end
  end
end
