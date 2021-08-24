# == Schema Information
#
# Table name: results
#
#  id         :bigint           not null, primary key
#  review_id  :integer
#  result     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class ResultTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
