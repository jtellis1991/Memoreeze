# == Schema Information
#
# Table name: explanations
#
#  id          :bigint           not null, primary key
#  explanation :text
#  target_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Explanation < ApplicationRecord
  belongs_to(:target, { :required => true, :class_name => "Target", :foreign_key => "target_id" })
end
