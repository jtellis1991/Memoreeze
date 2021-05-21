class ToolConsumer < ApplicationRecord
  has_many(:users, { :class_name => "User", :foreign_key => "tool_consumer_id", :dependent => :destroy })
  has_many(:courses, { :class_name => "Course", :foreign_key => "tool_consumer_id", :dependent => :destroy })

end
