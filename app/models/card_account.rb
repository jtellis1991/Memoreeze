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
end
