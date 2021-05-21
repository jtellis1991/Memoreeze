class Grade < ApplicationRecord
  belongs_to(:enrollment, { :required => false, :class_name => "Enrollment", :foreign_key => "enrollment_id" })
  belongs_to(:assignment, { :required => false, :class_name => "Assignment", :foreign_key => "assignment_id" })
  # has_many(:reviews, { :class_name => "Review", :foreign_key => "grade_id", :dependent => :destroy })

end
