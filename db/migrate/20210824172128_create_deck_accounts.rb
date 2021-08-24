class CreateDeckAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :deck_accounts do |t|
      t.integer :user_id
      t.integer :grade_id
      t.integer :deck_id
      t.boolean :is_todays_study_complete, :default => false

      t.timestamps
    end
  end
end
