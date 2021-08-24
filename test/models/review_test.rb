# == Schema Information
#
# Table name: reviews
#
#  id                   :bigint           not null, primary key
#  milliseconds_elapsed :string
#  card_account_id      :integer
#  grade_id             :integer
#  user_id              :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
require "test_helper"

class ReviewTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
