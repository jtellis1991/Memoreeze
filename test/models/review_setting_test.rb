# == Schema Information
#
# Table name: review_settings
#
#  id              :bigint           not null, primary key
#  user_id         :integer
#  reviews_per_day :string           default("10")
#  new_per_day     :integer          default(10)
#  time_zone       :string           default("Central Time (US & Canada)")
#  last_submission :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require "test_helper"

class ReviewSettingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
