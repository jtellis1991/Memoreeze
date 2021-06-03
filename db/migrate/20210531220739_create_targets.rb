class CreateTargets < ActiveRecord::Migration[6.1]
  def change
    create_table :targets do |t|
      t.string :body
      t.integer :card_id

      t.timestamps
    end
  end
end
