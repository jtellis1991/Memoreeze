# == Schema Information
#
# Table name: card_accounts
#
#  id              :bigint           not null, primary key
#  deck_account_id :integer
#  card_id         :integer
#  status          :integer          default(0)
#  last_interval   :integer          default(0)
#  next_review_due :string           default("0")
#  ease            :integer          default(250)
#  is_troublemaker :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class CardAccount < ApplicationRecord
  belongs_to :card, required: true, class_name: "Card", foreign_key: :card_id 
  belongs_to :deck_account, required: true, class_name: "DeckAccount", foreign_key: :deck_account_id 
  has_many :reviews, class_name: "Review", foreign_key: :review_id, dependent: :destroy

  enum status: [:learning, :relearning, :young, :mature]


end
