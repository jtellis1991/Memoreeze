# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  roles                  :string
#  tool_consumer_id       :integer
#  tc_user_id             :string
#  name                   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#
class User < ApplicationRecord
  before_save :set_name
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  
  belongs_to :tool_consumer, foreign_key: :tool_consumer_id, class_name: "ToolConsumer", required: false

  has_many :decks, foreign_key: :user_id, class_name: "Deck", dependent: :destroy 
  has_many :floating_decks, -> { where(assignment_id: nil) }, foreign_key: :user_id, class_name: "Deck"

  has_many :courses, foreign_key: :user_id, class_name: "Course", dependent: :destroy

  has_many :assignments, foreign_key: :user_id, class_name: "Assignment", dependent: :destroy
  has_many :floating_assignments, -> { where(deck_id: nil) }, foreign_key: :user_id, class_name: :Assignment

  has_one :review_setting, class_name: "ReviewSetting", foreign_key: :user_id, dependent: :destroy
  has_many :enrollments, class_name: "Enrollment", foreign_key: :user_id, dependent: :destroy
  has_many :grades, through: :enrollments

  has_many :reviews, foreign_key: :user_id, class_name: "Review", dependent: :destroy
  has_many :deck_accounts, foreign_key: :user_id, class_name: "DeckAccount", dependent: :destroy

  def set_name
    self.name = "username_" + (User.all.count + 1).to_s unless !self.name.blank?
  end
end
