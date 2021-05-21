class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.integer :role
      t.integer :tool_consumer_id

      t.timestamps
    end
  end
end
