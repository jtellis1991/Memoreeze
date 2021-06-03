class CreateResults < ActiveRecord::Migration[6.1]
  def change
    create_table :results do |t|
      t.integer :review_id
      t.float :again
      t.float :hard
      t.float :good
      t.float :easy

      t.timestamps
    end
  end
end
