# == Schema Information
#
# Table name: deck_accounts
#
#  id                       :bigint           not null, primary key
#  user_id                  :integer
#  grade_id                 :integer
#  deck_id                  :integer
#  is_todays_study_complete :boolean          default(FALSE)
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
class DeckAccount < ApplicationRecord
  belongs_to :user, required: true, class_name: "User", foreign_key: :user_id 
  belongs_to :grade, required: true, class_name: "Grade", foreign_key: :grade_id 
  belongs_to :deck, required: true, class_name: "Deck", foreign_key: :deck_id 
  has_many :card_accounts, class_name: "CardAccount", foreign_key: :deck_id, dependent: :destroy

end
