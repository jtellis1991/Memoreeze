# == Schema Information
#
# Table name: targets
#
#  id         :bigint           not null, primary key
#  body       :string
#  card_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Target < ApplicationRecord
  belongs_to(:card, { :required => false, :class_name => "Card", :foreign_key => "card_id" })

end
