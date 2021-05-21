class Enrollment < ApplicationRecord
  belongs_to(:user, { :required => false, :class_name => "User", :foreign_key => "user_id" })
  belongs_to(:course, { :required => false, :class_name => "Course", :foreign_key => "course_id" })
  has_many(:grades, { :class_name => "Grade", :foreign_key => "enrollment_id", :dependent => :destroy })


end
