class AddPrivateToDecks < ActiveRecord::Migration[6.1]
  def change
    add_column :decks, :private, :boolean, default: true
  end
end
