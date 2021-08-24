class CreateCardAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :card_accounts do |t|
      t.integer :deck_account_id
      t.integer :card_id
      t.integer :status, default: 0
      t.integer :last_interval, default: 0
      t.string  :next_review_due, default: 0
      t.integer :ease, default: 250
      t.boolean :is_troublemaker, default: false

      t.timestamps
    end
  end
end
