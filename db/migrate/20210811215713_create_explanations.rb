class CreateExplanations < ActiveRecord::Migration[6.1]
  def change
    create_table :explanations do |t|
      t.text :explanation
      t.integer :target_id

      t.timestamps
    end
  end
end
