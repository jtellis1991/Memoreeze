# == Schema Information
#
# Table name: assignments
#
#  id                  :bigint           not null, primary key
#  course_id           :integer
#  user_id             :integer
#  resource_link_id    :string
#  resource_link_title :string
#  deck_id             :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class Assignment < ApplicationRecord
  belongs_to :course,  required: false, class_name: "Course", foreign_key: :course_id 
  belongs_to :deck, required: false, class_name: "Deck", foreign_key: :deck_id 
  belongs_to :user, required: true, class_name: "User", foreign_key: :user_id

  has_many(:grades, { :class_name => "Grade", :foreign_key => "assignment_id", :dependent => :destroy })

end
