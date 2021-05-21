class User < ApplicationRecord
  # has_many(:decks, { :class_name => "Deck", :foreign_key => "user_id", :dependent => :destroy })
  # has_one(:review_setting, { :class_name => "ReviewSetting", :foreign_key => "user_id", :dependent => :destroy })
  has_many(:enrollments, { :class_name => "Enrollment", :foreign_key => "user_id", :dependent => :destroy })
  belongs_to(:tool_consumer, { :required => false, :class_name => "ToolConsumer", :foreign_key => "tool_consumer_id" })


  enum({ :role => { :student_teacher_admin => 0 } })

end
