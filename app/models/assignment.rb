# == Schema Information
#
# Table name: assignments
#
#  id               :bigint           not null, primary key
#  course_id        :integer
#  resource_link_id :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Assignment < ApplicationRecord
  belongs_to(:course, { :required => false, :class_name => "Course", :foreign_key => "course_id" })
  # has_many(:decks, { :class_name => "Deck", :foreign_key => "assignment_id", :dependent => :destroy })
  has_many(:grades, { :class_name => "Grade", :foreign_key => "assignment_id", :dependent => :destroy })

end
