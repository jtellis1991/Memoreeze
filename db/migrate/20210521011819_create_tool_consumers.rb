class CreateToolConsumers < ActiveRecord::Migration[6.1]
  def change
    create_table :tool_consumers do |t|
      t.string :guid
      t.string :name

      t.timestamps
    end
  end
end
