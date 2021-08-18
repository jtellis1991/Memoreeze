# == Schema Information
#
# Table name: decks
#
#  id         :bigint           not null, primary key
#  name       :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Deck < ApplicationRecord
  belongs_to :user, required: true, class_name: "User", foreign_key: :user_id 

  has_many :cards, class_name: "Card", foreign_key: :deck_id, dependent: :destroy

  has_many :assignments, class_name: "Assignment", foreign_key: :deck_id

  # has_many(:categories, { :through => :tags, :source => :category })
   # has_many(:tags, { :class_name => "Tag", :foreign_key => "deck_id", :dependent => :destroy })

end
