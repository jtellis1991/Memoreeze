class CreateCards < ActiveRecord::Migration[6.1]
  def change
    create_table :cards do |t|
      t.text :illustrative_test
      t.text :solution
      t.integer :deck_id
      t.integer :target_id  

      t.timestamps
    end
  end
end
