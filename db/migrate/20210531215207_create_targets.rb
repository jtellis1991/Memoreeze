class CreateTargets < ActiveRecord::Migration[6.1]
  def change
    create_table :targets do |t|
      t.string :target
      t.text   :explanation

      t.timestamps
    end
  end
end
