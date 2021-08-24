# == Schema Information
#
# Table name: reviews
#
#  id                   :bigint           not null, primary key
#  milliseconds_elapsed :string
#  card_account_id      :integer
#  grade_id             :integer
#  user_id              :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
class Review < ApplicationRecord
  belongs_to :card, required: true, class_name: "Card", foreign_key: :card_id
  belongs_to :user, required: false, class_name: "User", foreign_key: :user_id
  has_one :deck, through: :card


  has_one(:result, { :class_name => "Result", :foreign_key => "review_id", :dependent => :destroy })
  belongs_to(:grade, { :required => false, :class_name => "Grade", :foreign_key => "grade_id" })
  


end
