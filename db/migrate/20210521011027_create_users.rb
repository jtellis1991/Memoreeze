class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string  :roles
      t.integer :tool_consumer_id
      t.string  :tc_user_id
      t.string  :name
      
      t.timestamps
    end
  end
end
