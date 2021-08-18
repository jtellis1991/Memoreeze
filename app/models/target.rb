# == Schema Information
#
# Table name: targets
#
#  id          :bigint           not null, primary key
#  target      :string
#  explanation :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Target < ApplicationRecord
  has_many :cards, :class_name => "Card", :foreign_key => "target_id", :dependent => :destroy 
  
  validates :target, presence: true
  
end
