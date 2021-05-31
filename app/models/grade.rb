# == Schema Information
#
# Table name: grades
#
#  id            :bigint           not null, primary key
#  deck_id       :integer
#  score         :float
#  enrollment_id :integer
#  assignment_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Grade < ApplicationRecord
  belongs_to(:enrollment, { :required => false, :class_name => "Enrollment", :foreign_key => "enrollment_id" })
  belongs_to(:assignment, { :required => false, :class_name => "Assignment", :foreign_key => "assignment_id" })
  # has_many(:reviews, { :class_name => "Review", :foreign_key => "grade_id", :dependent => :destroy })

end
