# == Schema Information
#
# Table name: card_accounts
#
#  id              :bigint           not null, primary key
#  deck_account_id :integer
#  card_id         :integer
#  status          :integer          default("learning")
#  last_interval   :integer          default(0)
#  next_review_due :string           default("0")
#  ease            :integer          default(250)
#  is_troublemaker :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require "test_helper"

class CardAccountTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
