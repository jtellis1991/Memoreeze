# == Schema Information
#
# Table name: cards
#
#  id                :bigint           not null, primary key
#  illustrative_test :text
#  solution          :text
#  deck_id           :integer
#  target_id         :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class Card < ApplicationRecord
  belongs_to :target,  :required => true, :class_name => "Target", :foreign_key => "target_id"

  has_many(:reviews, { :class_name => "Review", :foreign_key => "card_id", :dependent => :destroy })
  
  belongs_to :deck, :required => true, :class_name => "Deck", :foreign_key => "deck_id" 
  
  validates :illustrative_test, :solution, presence: true
end
