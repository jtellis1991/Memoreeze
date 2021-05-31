# == Schema Information
#
# Table name: review_settings
#
#  id              :bigint           not null, primary key
#  user_id         :integer
#  reviews_per_day :string
#  new_per_day     :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require "test_helper"

class ReviewSettingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
