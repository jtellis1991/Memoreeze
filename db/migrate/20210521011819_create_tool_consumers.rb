class CreateToolConsumers < ActiveRecord::Migration[6.1]
  def change
    create_table :tool_consumers do |t|
      t.string  :guid
      t.string  :name
      t.string  :product_family 

      t.timestamps
    end
  end
end
