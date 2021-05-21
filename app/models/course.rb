class Course < ApplicationRecord
  has_many(:enrollments, { :class_name => "Enrollment", :foreign_key => "course_id", :dependent => :destroy })
  has_many(:assignments, { :class_name => "Assignment", :foreign_key => "course_id", :dependent => :destroy })
  belongs_to(:tool_consumer, { :required => false, :class_name => "ToolConsumer", :foreign_key => "tool_consumer_id" })


end
