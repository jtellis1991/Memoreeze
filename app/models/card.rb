# == Schema Information
#
# Table name: cards
#
#  id         :bigint           not null, primary key
#  front      :text
#  back       :text
#  deck_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Card < ApplicationRecord
  has_one(:target, { :class_name => "Target", :foreign_key => "card_id", :dependent => :destroy })
  has_many(:reviews, { :class_name => "Review", :foreign_key => "card_id", :dependent => :destroy })
  belongs_to(:deck, { :required => false, :class_name => "Deck", :foreign_key => "deck_id" })
  
end
