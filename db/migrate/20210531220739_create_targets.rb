class CreateTargets < ActiveRecord::Migration[6.1]
  def change
    create_table :targets do |t|
      t.string :target
      t.integer :card_id

      t.timestamps
    end
  end
end
