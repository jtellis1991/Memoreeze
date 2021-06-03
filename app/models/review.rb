# == Schema Information
#
# Table name: reviews
#
#  id                   :bigint           not null, primary key
#  next_review          :integer
#  milliseconds_elapsed :string
#  card_id              :integer
#  grade_id             :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
class Review < ApplicationRecord
  belongs_to(:card, { :required => false, :class_name => "Card", :foreign_key => "card_id" })
  has_one(:result, { :class_name => "Result", :foreign_key => "review_id", :dependent => :destroy })
  belongs_to(:grade, { :required => false, :class_name => "Grade", :foreign_key => "grade_id" })

end
