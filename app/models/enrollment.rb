# == Schema Information
#
# Table name: enrollments
#
#  id         :bigint           not null, primary key
#  user_id    :integer
#  course_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Enrollment < ApplicationRecord
  belongs_to(:user, { :required => false, :class_name => "User", :foreign_key => "user_id" })
  belongs_to(:course, { :required => false, :class_name => "Course", :foreign_key => "course_id" })
  has_many(:grades, { :class_name => "Grade", :foreign_key => "enrollment_id", :dependent => :destroy })


end
