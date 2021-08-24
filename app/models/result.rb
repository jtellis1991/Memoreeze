# == Schema Information
#
# Table name: results
#
#  id         :bigint           not null, primary key
#  review_id  :integer
#  result     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Result < ApplicationRecord
  belongs_to :review, required: true, class_name: "Review", foreign_key: :review_id

  enum result: [:easy, :good, :hard, :again]

end
