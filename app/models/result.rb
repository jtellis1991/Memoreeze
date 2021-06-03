# == Schema Information
#
# Table name: results
#
#  id         :bigint           not null, primary key
#  review_id  :integer
#  again      :float
#  hard       :float
#  good       :float
#  easy       :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Result < ApplicationRecord
  belongs_to(:review, { :required => false, :class_name => "Review", :foreign_key => "review_id" })

end
