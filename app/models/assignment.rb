class Assignment < ApplicationRecord
  belongs_to(:course, { :required => false, :class_name => "Course", :foreign_key => "course_id" })
  # has_many(:decks, { :class_name => "Deck", :foreign_key => "assignment_id", :dependent => :destroy })
  has_many(:grades, { :class_name => "Grade", :foreign_key => "assignment_id", :dependent => :destroy })

end
