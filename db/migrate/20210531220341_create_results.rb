class CreateResults < ActiveRecord::Migration[6.1]
  def change
    create_table :results do |t|
      t.integer :review_id
      t.integer :result

      t.timestamps
    end
  end
end
