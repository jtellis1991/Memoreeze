# == Schema Information
#
# Table name: users
#
#  id               :bigint           not null, primary key
#  roles            :string
#  tool_consumer_id :integer
#  tc_user_id       :string
#  name             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class User < ApplicationRecord

  has_many :decks, foreign_key: :user_id, class_name: "Deck", dependent: :destroy 

  has_many :floating_decks, -> { where(assignment_id: nil) }, foreign_key: :user_id, class_name: "Deck"

  has_many :courses, foreign_key: :user_id, class_name: "Course", dependent: :destroy

  has_many :assignments, foreign_key: :user_id, class_name: "Assignment", dependent: :destroy

  has_many :floating_assignments, -> { where(deck_id: nil) }, foreign_key: :user_id, class_name: :Assignment

  belongs_to :tool_consumer, foreign_key: :tool_consumer_id, class_name: "ToolConsumer", required: false

  has_many :reviews, foreign_key: :user_id, class_name: "Review", dependent: :destroy

  has_many(:enrollments, { :class_name => "Enrollment", :foreign_key => "user_id", :dependent => :destroy })
  
  has_one(:review_setting, { :class_name => "ReviewSetting", :foreign_key => "user_id", :dependent => :destroy })


end
